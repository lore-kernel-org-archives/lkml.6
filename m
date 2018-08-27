Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C520898
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1qAFI17+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615C520898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeH0QPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:15:14 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38254 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0QPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:15:14 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so10191555ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jp1RsIGxKGYhbx7WsB6UMwgH0lcSbkdJqIRzAaLejWY=;
        b=1qAFI17+4mQuoRJMg3LEPDnpFFiQHvKORJaKf6cTIHBEhSbRv2vrwjGEyWPFKSHivG
         tU3iTX8FqIqAjShRUcB04EulkEE0RXrOaqRf19ngh9SB9LmCA+s9LmzXeBlUJBoziNZX
         symL/HBvmA7pBeCtYqs48KK3bYGi7ktnBCz05662oIlx4NoTzAcRykW3rf46tTIh0BcF
         y7MnQEZm8tNG0SIAmfAigpvYaj97WDV3bq2665GvA1gYV8lqbqkdR76FhKY0YC3lcX9Z
         dU2Z55WBokxbdpJ9wqp3uk7Tu/UNbghxx1Uhxc13In5enpAXExM24AdB74sullXPcO1u
         houQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jp1RsIGxKGYhbx7WsB6UMwgH0lcSbkdJqIRzAaLejWY=;
        b=r3Ai1gqm5yfovUUs8Zvo2cyeJ+8G0XSAEvkx3cqeZqpmd67bSxLt5BZ1pSFYgbu63W
         5D9vKp8Oa6hEq/qP3jvSfs83TGjJBt9d23G70V/3qfNtcwQ1izD8gwpA9jlM5sF+mwcX
         7b8m42HgV3YWzpyGVv1HQxs9YeY06eHfZBXSVVOGCEFJAgKsQYhCYY8uAquZOG583xNy
         RNWwlBzh3X2+mzVIatZsB2WXAp1JLsXkp+x1WzaHn40e/mJkRQcVXL4Wb2g/vMfg1knV
         5qeBLkmTB+ho6xY8YQy3M7caaM9l686UTWq9Wz0DGpm/5fUWZDsXTFxXh8j7KYI/4HCD
         tkwA==
X-Gm-Message-State: APzg51DDp3RdZFJL/WRcUjIOdCy6bncPua5ks+Krc/+ahMykLlJs4BJH
        BgmvmXG/L5oHyW8B0dMLpNB2G9lAkLLS0V0z+6PZCA==
X-Google-Smtp-Source: ANB0VdYR7VEWWcxHtSBoJuC9I+YHuVXHVmQ/bioSXDWg9TQiDvt9S3pEIGJxzsDdpOUx7CMcxTxXm83NCTzoj22IDSo=
X-Received: by 2002:a24:41cd:: with SMTP id b74-v6mr6517196itd.85.1535372926403;
 Mon, 27 Aug 2018 05:28:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 05:28:45
 -0700 (PDT)
In-Reply-To: <20180827103915.GC13848@rapoport-lnx>
References: <20180827082101.5036-1-brgl@bgdev.pl> <20180827082101.5036-2-brgl@bgdev.pl>
 <20180827103915.GC13848@rapoport-lnx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Aug 2018 14:28:45 +0200
Message-ID: <CAMRc=MeCRw459ppuVK=w53C2eHOVVHPksF_4hx_dY1J-3fgPsQ@mail.gmail.com>
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

2018-08-27 12:39 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
> On Mon, Aug 27, 2018 at 10:21:01AM +0200, Bartosz Golaszewski wrote:
>> Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
>> an example of how to use this new routine to shrink driver code.
>>
>> While we're at it: replace a call to kcalloc() with devm_kcalloc().
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
>>  1 file changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
>> index 08ef69945ffb..daa2192e6568 100644
>> --- a/drivers/clk/x86/clk-pmc-atom.c
>> +++ b/drivers/clk/x86/clk-pmc-atom.c
>> @@ -253,14 +253,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
>>               plt_clk_unregister_fixed_rate(data->parents[i]);
>>  }
>>
>> -static void plt_clk_free_parent_names_loop(const char **parent_names,
>> -                                        unsigned int i)
>> -{
>> -     while (i--)
>> -             kfree_const(parent_names[i]);
>> -     kfree(parent_names);
>> -}
>> -
>>  static void plt_clk_unregister_loop(struct clk_plt_data *data,
>>                                   unsigned int i)
>>  {
>> @@ -286,8 +278,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>>       if (!data->parents)
>>               return ERR_PTR(-ENOMEM);
>>
>> -     parent_names = kcalloc(nparents, sizeof(*parent_names),
>> -                            GFP_KERNEL);
>> +     parent_names = devm_kcalloc(&pdev->dev, nparents,
>> +                                 sizeof(*parent_names), GFP_KERNEL);
>>       if (!parent_names)
>>               return ERR_PTR(-ENOMEM);
>>
>> @@ -300,7 +292,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>>                       err = PTR_ERR(data->parents[i]);
>>                       goto err_unreg;
>>               }
>> -             parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
>> +             parent_names[i] = devm_kstrdup_const(&pdev->dev,
>> +                                                  clks[i].name, GFP_KERNEL);
>>       }
>>
>>       data->nparents = nparents;
>> @@ -308,7 +301,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>>
>>  err_unreg:
>>       plt_clk_unregister_fixed_rate_loop(data, i);
>> -     plt_clk_free_parent_names_loop(parent_names, i);
>
> What happens if clks[i].name is not a part of RO data? The devm_kstrdup_const
> will allocate memory and nothing will ever free it...
>

I'm looking at it and trying to see if I'm missing something, but
AFAIK the whole concept of devm_* is to leave out the resource
management part.

devm_kstrdup_const() will internally call devm_kstrdup() for strings
that are not in .rodata and once the device is detached, the string
will be freed (or not if it's in .rodata).

BR
Bart

> And, please don't drop kfree(parent_names) here.
>
>>       return ERR_PTR(err);
>>  }
>>
>> @@ -351,15 +343,12 @@ static int plt_clk_probe(struct platform_device *pdev)
>>               goto err_unreg_clk_plt;
>>       }
>>
>> -     plt_clk_free_parent_names_loop(parent_names, data->nparents);
>> -
>>       platform_set_drvdata(pdev, data);
>>       return 0;
>>
>>  err_unreg_clk_plt:
>>       plt_clk_unregister_loop(data, i);
>>       plt_clk_unregister_parents(data);
>> -     plt_clk_free_parent_names_loop(parent_names, data->nparents);
>
> Ditto.
>
>>       return err;
>>  }
>>
>> --
>> 2.18.0
>>
>
> --
> Sincerely yours,
> Mike.
>
