Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385DC20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qJ4qp+uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385DC20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeH0QpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:45:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36164 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeH0QpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:45:21 -0400
Received: by mail-io0-f196.google.com with SMTP id q5-v6so9477641iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ebhA6mp22PxLzUQAFm1Da376tltX3rYnvGhJ4FPB9/o=;
        b=qJ4qp+uS7pXdAicfjnU92YkoweqU91A4lfEjA7Xl7GB22URUwn+NHgr9TG6w/go5I1
         2ln7mipDqWDRE5ruMM3YkfeM+xamcLzyqzrbwfNrtb9661qmpnkM0K7g46SxuDT5GRWX
         +8ZAxrsd5UYhRTOwGEEHK/sJd2anUMyLSDcnjkDkwL701jtUEm62F/kqZxZRw7AzD+J+
         jPEaSXZwMdT4zX2QPNBEYxuzmRFXi+vSDUWjlhYNmrPl2rI+TRroJSbSC8DAKvO3qArT
         fj+vggc1CM3zqPcUZLMlHgPzAVOTSFeMOVbsnviPERalAdytzzQIh9SqkhOK92i18DcN
         iPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ebhA6mp22PxLzUQAFm1Da376tltX3rYnvGhJ4FPB9/o=;
        b=UkohIetbMKsxzNqX4es5Hsb/akksBqT+kBrpJEYsQ4QL8BOixni1aYokBaokI1h++1
         LQkqYi8B0TNjDp8R+v58gXGPpRIyzkv/jznFbsNE36Yku1Wgd9ZyJePRJo53FV6vfjbZ
         kHvK1CnLgr1mBZf3N5ShgLRLR4tsEWK+dYpnAJG8A3aNT5iOgrTnCBCO8Ikt6/AMqBdm
         f9ompIpr6ZwyAC7qQfMhNjVuqb1WOBv/XMPpxtBxLjgzCkFkuk8IZ/6raOVN9xHKUxCi
         +HdDxm5vWbfcdKZviopftvXxXjgUuwykY+mWfJdgmZrO+UVdpWkz9fdf3pKA75Wd3c2/
         W5Ng==
X-Gm-Message-State: APzg51AmbpD1xi+GSSsTkqpBxBoBWznTAiv3j02utM/ynawJCkGSkwf/
        FwN6ztoWEXu9918x2c67H0CQXAaO/U44qJDqnan7Qw==
X-Google-Smtp-Source: ANB0VdZIhzSLmkH1swhdHwOjNFGmZH4ViSGmctFOoNKLmHNrQeLXcO+bM6/IAF58kN+o+qrMTXh99zZyFVAQoL5QReM=
X-Received: by 2002:a6b:9157:: with SMTP id t84-v6mr9972718iod.187.1535374726710;
 Mon, 27 Aug 2018 05:58:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 05:58:46
 -0700 (PDT)
In-Reply-To: <20180827125226.GD13848@rapoport-lnx>
References: <20180827082101.5036-1-brgl@bgdev.pl> <20180827082101.5036-2-brgl@bgdev.pl>
 <20180827103915.GC13848@rapoport-lnx> <CAMRc=MeCRw459ppuVK=w53C2eHOVVHPksF_4hx_dY1J-3fgPsQ@mail.gmail.com>
 <20180827125226.GD13848@rapoport-lnx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Aug 2018 14:58:46 +0200
Message-ID: <CAMRc=MchWQEiH82KYdXvPWzJ6U9YLLJ8425M3Jct1O0EMZpokA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: pmc-atom: use devm_kstrdup_const()
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-27 14:52 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
> On Mon, Aug 27, 2018 at 02:28:45PM +0200, Bartosz Golaszewski wrote:
>> 2018-08-27 12:39 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
>> > On Mon, Aug 27, 2018 at 10:21:01AM +0200, Bartosz Golaszewski wrote:
>> >> Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
>> >> an example of how to use this new routine to shrink driver code.
>> >>
>> >> While we're at it: replace a call to kcalloc() with devm_kcalloc().
>> >>
>> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> >> ---
>> >>  drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
>> >>  1 file changed, 4 insertions(+), 15 deletions(-)
>> >>
>> >> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
>> >> index 08ef69945ffb..daa2192e6568 100644
>> >> --- a/drivers/clk/x86/clk-pmc-atom.c
>> >> +++ b/drivers/clk/x86/clk-pmc-atom.c
>> >> @@ -253,14 +253,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
>> >>               plt_clk_unregister_fixed_rate(data->parents[i]);
>> >>  }
>> >>
>> >> -static void plt_clk_free_parent_names_loop(const char **parent_names,
>> >> -                                        unsigned int i)
>> >> -{
>> >> -     while (i--)
>> >> -             kfree_const(parent_names[i]);
>> >> -     kfree(parent_names);
>> >> -}
>> >> -
>> >>  static void plt_clk_unregister_loop(struct clk_plt_data *data,
>> >>                                   unsigned int i)
>> >>  {
>> >> @@ -286,8 +278,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>> >>       if (!data->parents)
>> >>               return ERR_PTR(-ENOMEM);
>> >>
>> >> -     parent_names = kcalloc(nparents, sizeof(*parent_names),
>> >> -                            GFP_KERNEL);
>> >> +     parent_names = devm_kcalloc(&pdev->dev, nparents,
>> >> +                                 sizeof(*parent_names), GFP_KERNEL);
>> >>       if (!parent_names)
>> >>               return ERR_PTR(-ENOMEM);
>> >>
>> >> @@ -300,7 +292,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>> >>                       err = PTR_ERR(data->parents[i]);
>> >>                       goto err_unreg;
>> >>               }
>> >> -             parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
>> >> +             parent_names[i] = devm_kstrdup_const(&pdev->dev,
>> >> +                                                  clks[i].name, GFP_KERNEL);
>> >>       }
>> >>
>> >>       data->nparents = nparents;
>> >> @@ -308,7 +301,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>> >>
>> >>  err_unreg:
>> >>       plt_clk_unregister_fixed_rate_loop(data, i);
>> >> -     plt_clk_free_parent_names_loop(parent_names, i);
>> >
>> > What happens if clks[i].name is not a part of RO data? The devm_kstrdup_const
>> > will allocate memory and nothing will ever free it...
>> >
>>
>> I'm looking at it and trying to see if I'm missing something, but
>> AFAIK the whole concept of devm_* is to leave out the resource
>> management part.
>>
>> devm_kstrdup_const() will internally call devm_kstrdup() for strings
>> that are not in .rodata and once the device is detached, the string
>> will be freed (or not if it's in .rodata).
>
> And when it's going to be freed, how the resource management will know
> whether it's .rodata or not?
>

If the string to be duplicated is in .rodata, it's returned as is from
devm_kstrdup_const(). Never gets added to the devres list, never get's
freed. When the string to be duplicated is not in .rodata,
devm_kstrdup() is called from devm_kstrdup_const(). Now the string is
in the devres list of this device and it will get freed on driver
detach. I really don't see what else could be a problem here.

BR
Bart

>> BR
>> Bart
>>
>> > And, please don't drop kfree(parent_names) here.
>> >
>> >>       return ERR_PTR(err);
>> >>  }
>> >>
>> >> @@ -351,15 +343,12 @@ static int plt_clk_probe(struct platform_device *pdev)
>> >>               goto err_unreg_clk_plt;
>> >>       }
>> >>
>> >> -     plt_clk_free_parent_names_loop(parent_names, data->nparents);
>> >> -
>> >>       platform_set_drvdata(pdev, data);
>> >>       return 0;
>> >>
>> >>  err_unreg_clk_plt:
>> >>       plt_clk_unregister_loop(data, i);
>> >>       plt_clk_unregister_parents(data);
>> >> -     plt_clk_free_parent_names_loop(parent_names, data->nparents);
>> >
>> > Ditto.
>> >
>> >>       return err;
>> >>  }
>> >>
>> >> --
>> >> 2.18.0
>> >>
>> >
>> > --
>> > Sincerely yours,
>> > Mike.
>> >
>>
>
> --
> Sincerely yours,
> Mike.
>
