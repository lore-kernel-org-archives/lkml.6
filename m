Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F7ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121542054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJwsiw+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121542054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeJSDEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:04:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeJSDEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:04:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id r190-v6so2988953pgr.13;
        Thu, 18 Oct 2018 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c8c/YKFOurrxuiYDsv6SSbr24JEeZeRwF7ACeKHdCY0=;
        b=AJwsiw+aoRtddCxQF4kA7SKieSMjBM1gi4pLvBpP7Wyh17aMiGdz1Ikc6pkX7tVtm4
         8wnEj0SJwOi5+3I/Brg76gZTzyJJCk1qpRNtNjKc+rFhsGAxylKYbygRc0U1EcXLAg1q
         /K9LeWVw6MM2G54sCdrc5zDmgPqIO0VAFqjy9lj+95hoPkL6Wb1E/vHuUJ0HHR99mv46
         r6mQeV3pZH/gLGWw2LYbTwz9YSKBHen8o4RMsH2rwoql9ywB7IADczTE9aq+px4FZzDH
         xyK1q5qcTYy5+ehYa6vJ8K4G0PonQU/ItAVFGATyP9rsYbBDDg5An5DXnjGLqnrU8NzN
         RNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c8c/YKFOurrxuiYDsv6SSbr24JEeZeRwF7ACeKHdCY0=;
        b=J9uxiOoAPbTEiD91vjwOMTMl5QsCYf69QJp1brS0Y2akxjqHtRgxpytTqnrWMEFJfc
         5TkL2Wqkq9nS0OkOqAkTSTQLJ9+sKv1WFbvZxEh+aYUmtCCkgthpa7ZEvZCKjI8dQwBO
         WT7+4EsTDf6Y7tCTjs3KwPMKPaLRcuW+nUMUsUmrZCxNe9RFGTFKDxJdq3ovYzB3qli3
         Avy7yaOe/3E9wlm5bz3tpGZSv0N1ewkjFiYWDuZAWafKXHN/KlVCFf55KDsAglAu82A8
         /72hIze9vtT3ve5TEzODzkbdZsQXUiTvpgCR0zP7rluMeKfCd8swfmAMC9i3SY2QOhe3
         UK4A==
X-Gm-Message-State: ABuFfogfNINE0XvxNP1yEJ43OEV97GQwH8Y+breJdzbJo/Z4rGcaP2AE
        613VDtsQGNO6ddyGsB2zHiuRTslp
X-Google-Smtp-Source: ACcGV63J0hRNaPnkYdhN7pK+spiOnUI3NCscZBief4XvI51YV88TsVlqM7kfY0s8B6dkdA+KmD5l1A==
X-Received: by 2002:a63:5605:: with SMTP id k5-v6mr29957478pgb.189.1539889312064;
        Thu, 18 Oct 2018 12:01:52 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e22-v6sm22474840pfi.61.2018.10.18.12.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:01:51 -0700 (PDT)
Subject: Re: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
To:     Rob Herring <robh@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
 <20181018170303.GA15557@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f6aaf5be-ed08-a055-c270-4284ed6532a9@gmail.com>
Date:   Thu, 18 Oct 2018 12:01:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018170303.GA15557@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 10:03, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:21PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks:
>>   - attempted kfree due to refcount reaching zero before overlay
>>     is removed
>>   - properties linked to an overlay node when the node is removed
>>   - node refcount > one during node removal in a changeset destroy,
>>     if the node was created by the changeset
>>
>> After applying this patch, several validation warnings will be
>> reported from the devicetree unittest during boot due to
>> pre-existing devicetree bugs. The warnings will be similar to:
>>
>>   OF: ERROR: of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest11/test-unittest111 contains unexpected properties
>>   OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 expected refcount 1 instead of 2.  of_node_get() / of_node_put() are unbalanced for this node.
> 
> These messages could be formatted more consistently. Put the path either 
> at the beginning (after any prefix) or end. Beginning is more like a 
> compiler error. End puts what the problem is before it's off the edge of 
> the screen. 

The inconsistency makes the word flow more natural, but I agree that
consistency is more important.  I think I can make all the messages
say the problem first, then provide the path at the end.


>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> Changes since v3:
>>   - Add expected value of refcount for destroy cset entry error.  Also
>>     explain the cause of the error.
>>
>>  drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
>>  drivers/of/overlay.c |  1 +
>>  include/linux/of.h   | 15 ++++++++++-----
>>  3 files changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index f4f8ed9b5454..24c97b7a050f 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
>>  	if (!of_node_check_flag(node, OF_DYNAMIC))
>>  		return;
>>  
>> +	if (of_node_check_flag(node, OF_OVERLAY)) {
>> +
>> +		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
> 
> I worry the flags are getting unwieldy.

I considered that.  I think we are still ok, and I don't have a better
solution than adding flag values.  (I did have some Rube Goldberg
variations.)


> 
>> +			/* premature refcount of zero, do not free memory */
>> +			pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
>> +			       __func__, node);
>> +			return;
>> +		}
>> +
>> +		/*
>> +		 * If node->properties non-empty then properties were added
>> +		 * to this node either by different overlay that has not
>> +		 * yet been removed, or by a non-overlay mechanism.
>> +		 */
>> +		if (node->properties)
>> +			pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
>> +			       __func__, node);
>> +	}
>> +
>>  	property_list_free(node->properties);
>>  	property_list_free(node->deadprops);
>>  
>> @@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
>>  
>>  static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
>>  {
>> +	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
>> +	    of_node_check_flag(ce->np, OF_OVERLAY)) {
>> +		if (kref_read(&ce->np->kobj.kref) > 1) {
>> +			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
>> +			       ce->np, kref_read(&ce->np->kobj.kref));
>> +		} else {
>> +			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
>> +		}
>> +	}
>> +
>>  	of_node_put(ce->np);
>>  	list_del(&ce->node);
>>  	kfree(ce);
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index eda57ef12fd0..1176cb4b6e4e 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>>  			return -ENOMEM;
>>  
>>  		tchild->parent = target_node;
>> +		of_node_set_flag(tchild, OF_OVERLAY);
>>  
>>  		ret = of_changeset_attach_node(&ovcs->cset, tchild);
>>  		if (ret)
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 4d25e4f952d9..aa1dafaec6ae 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
>>  extern struct device_node *of_stdout;
>>  extern raw_spinlock_t devtree_lock;
>>  
>> -/* flag descriptions (need to be visible even when !CONFIG_OF) */
>> -#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
>> -#define OF_DETACHED	2 /* node has been detached from the device tree */
>> -#define OF_POPULATED	3 /* device already created for the node */
>> -#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
>> +/*
>> + * struct device_node flag descriptions
>> + * (need to be visible even when !CONFIG_OF)
>> + */
>> +#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
>> +#define OF_DETACHED		2 /* detached from the device tree */
>> +#define OF_POPULATED		3 /* device already created */
>> +#define OF_POPULATED_BUS	4 /* platform bus created for children */
>> +#define OF_OVERLAY		5 /* allocated for an overlay */
>> +#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
>>  
>>  #define OF_BAD_ADDR	((u64)-1)
>>  
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
>>
> 

