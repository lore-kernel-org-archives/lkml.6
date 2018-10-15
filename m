Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF7C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264E420652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/hxWOO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJOIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:12:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeJOIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:12:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so8294223pgc.8;
        Sun, 14 Oct 2018 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5o/wKl0UtRTrSQOwevxWhjE/eXwm/pLu6WI0xVrkfhU=;
        b=T/hxWOO8E5u3HVWvvdtbdRbYnHWDdh4TV+5oPFRxr24Wvrbqfg1XJzsyg+PW4G02QE
         tG/M0J9pucc3+j0xhf9Lrc5Zi+HxHuxW8jdOxne5avJZUlhWHa+bymPp0WTVnMpGpaL1
         QrHAivmzf71YK4hlq5U+1vMk/yefOzCGIScke7DqdQ2oEZ92ujL6cU/2YLfge8gFrRSv
         apTvCDb9g4r1hpkqIiXiy1MUgTAOwbk/+qJ9VTAL62GiyPLTg5S3q2B7uxvd291aqxFL
         jk5LOeNiM85fFlJQhwrEn4G6cV2mM0cgYpal0cJCMUhPe+Z+B+IlpGCHo7KIYvYv+M7p
         0XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5o/wKl0UtRTrSQOwevxWhjE/eXwm/pLu6WI0xVrkfhU=;
        b=OuutfeHjGH0QRB3DFhw0dezWb0/WJ3lhSp/zVspmlIfaiqBHutjcLpNVd9BJkQPEKN
         IoFFnlknt+Fa7luYnJupjAVt+u19KI7e5kMRibirHKfwR/+Sz2pAvMSzh2Vj4JE6eotn
         niSh6eXVrfZmYGJMKy4UPUR3j5CHRzT4oBLt64TjLidacAgG97cqG+erKMG1xt1AQSSP
         6eLvriIHSi48wx0MXXwFtmw+BownRl+3o6bf7DznBloujTGqRiZs9kBCdLd41/bJ6PiB
         VjU4ObXuLNfEultVy2or1T82DSzKGSoKyg6F5pbca7uySqGrzC9PSv0XU4Cst1X1Mgzk
         IOrw==
X-Gm-Message-State: ABuFfogHIMseU17xuCoEk9Shagj1eoAgD4/WLVCAoYudBOvwPAReSRrV
        Ec5zVIY41pMcD8Zqt6MeZ+4cwnUi
X-Google-Smtp-Source: ACcGV604mIqkHeaB14gcPNus6R31NLhilnJ9cIc5Q7XE83z/1r3tFRmkByauVV1eES7kTpDLBn+L1g==
X-Received: by 2002:a63:214d:: with SMTP id s13-v6mr14112721pgm.148.1539563356354;
        Sun, 14 Oct 2018 17:29:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f1-v6sm14901470pgc.4.2018.10.14.17.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 17:29:15 -0700 (PDT)
Subject: Re: [PATCH v2 12/18] of: overlay: check prevents multiple fragments
 add or delete same node
From:   Frank Rowand <frowand.list@gmail.com>
To:     Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
 <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
 <97b26203e6792795bdc0a66ce4cdb47571ff16c1.camel@perches.com>
 <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
Message-ID: <06898888-59dc-c37f-5013-a58fc73df2e1@gmail.com>
Date:   Sun, 14 Oct 2018 17:29:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/18 11:21, Frank Rowand wrote:
> On 10/13/18 05:51, Joe Perches wrote:
>> On Fri, 2018-10-12 at 21:53 -0700, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Multiple overlay fragments adding or deleting the same node is not
>>> supported.  Replace code comment of such, with check to detect the
>>> attempt and fail the overlay apply.
>>>
>>> Devicetree unittest where multiple fragments added the same node was
>>> added in the previous patch in the series.  After applying this patch
>>> the unittest messages will no longer include:
>>>
>>>    Duplicate name in motor-1, renamed to "controller#1"
>>>    OF: overlay: of_overlay_apply() err=0
>>>    ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
>>>    ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed
>>>
>>>    ...
>>>
>>>    ### dt-test ### end of unittest - 210 passed, 1 failed
>>>
>>> but will instead include:
>>>
>>>    OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
>>>
>>>    ...
>>>
>>>    ### dt-test ### end of unittest - 211 passed, 0 failed
>> []
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> []
>>> @@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
>>>  }
>>>  
>>>  /**
>>> + * check_changeset_dup_add_node() - changeset validation: duplicate add node
>>> + * @ovcs:	Overlay changeset
>>> + *
>>> + * Check changeset @ovcs->cset for multiple add node entries for the same
>>> + * node.
>>> + *
>>> + * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
>>> + * invalid overlay in @ovcs->fragments[].
>>> + */
>>> +static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
>>> +{
>>> +	struct of_changeset_entry *ce_1, *ce_2;
>>> +	char *fn_1, *fn_2;
>>> +	int name_match;
>>> +
>>> +	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>>> +
>>> +		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
>>> +		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
>>> +
>>> +			ce_2 = ce_1;
>>> +			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>>> +				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
>>> +				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
>>> +					/* inexpensive name compare */
>>> +					if (!of_node_cmp(ce_1->np->full_name,
>>> +					    ce_2->np->full_name)) {
>>
>> A bit of odd indentation here.
>> This line is normally aligned to the second ( on the line above.
> 
> Yes, thanks.

This line gets joined into a single line in version 3, so I will leave
the bad formatting in patch 12 to make my life easier when moving
to version 3.


>>
>>> +						/* expensive full path name compare */
>>> +						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>>> +						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>>> +						name_match = !strcmp(fn_1, fn_2);
>>> +						kfree(fn_1);
>>> +						kfree(fn_2);
>>> +						if (name_match) {
>>> +							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>>> +							       ce_1->np);
>>> +							return -EINVAL;
>>> +						}
>>> +					}
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> Style trivia:
>>
>> Using inverted tests and continue would reduce indentation.
> 
> Yes, thanks.

In version 3, fixed in patch 13/18 instead of 12/18, where this pattern
has been split into two functions.

-Frank


> 
> -Frank
> 
> 
>>
>> 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>> 		if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
>> 		    ce_1->action != OF_RECONFIG_DETACH_NODE)
>> 			continue;
>>
>> 		ce_2 = ce_1;
>> 		list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>> 			if (ce_2->action != OF_RECONFIG_ATTACH_NODE &&
>> 			    ce_2->action != OF_RECONFIG_DETACH_NODE)
>> 				continue;
>>
>> 			/* inexpensive name compare */
>> 			if (of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
>> 				continue;
>>
>> 			/* expensive full path name compare */
>> 			fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>> 			fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> 			name_match = !strcmp(fn_1, fn_2);
>> 			kfree(fn_1);
>> 			kfree(fn_2);
>> 			if (name_match) {
>> 				pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>> 				       ce_1->np);
>> 				return -EINVAL;
>> 			}
>> 		}
>> 	}
>>
>>
>>
> 
> 

