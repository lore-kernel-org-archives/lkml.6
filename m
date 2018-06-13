Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 53840C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD88208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9AWbRCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD88208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935096AbeFMRim (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:38:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34424 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754487AbeFMRik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:38:40 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so1624104pgr.1;
        Wed, 13 Jun 2018 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=vQCVuhzHUOYNIPDzZQPMVDe6yQ6JfIdSyZK8SDXiegg=;
        b=q9AWbRCNMAx8TWQs5t93SyvROk1ogbLwiDxzN7FhvpQ8JNLnRfYZIMP1WtN7N62HBJ
         2BDYUmXiJDgFIkaZm6x582cUyDA0mA5AHNfmsOZYmM+T5gUcFl/z58B/PlEQKNg3DmB5
         jxOoYS0swVcsHLn2uzo6eTCoKirvjPMCOOskMKul9VlKVG528kqHF9v+7tSMeBJ/+9JT
         X1c2uMPyqsEbGAZLtY94rYag74yW3Uo9MZ/m4xlkWECDvYLMV37dp55z3LD8G1zDjUBS
         ZqDjrgxD8Z7KWsNWhSUk0QKj7fKNU3aw2NMszLVtG0BxvldP1vOaf78G/1irH+5sSdz6
         h20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vQCVuhzHUOYNIPDzZQPMVDe6yQ6JfIdSyZK8SDXiegg=;
        b=mA3C4h3QHe8UjQfJGwtu+oyeEFBFJaKkJM32EgnaHGsuj3U+yKkQYGHavvlijutjui
         hIE0VdYCQmylgt+jyNjm560/ICTDSv4XFzK1kSXtugwtyYotXeQtIDW5F2SgcuwOog9G
         Biz9bX92uF96Av5B6UINITphiTaMzdOGANMH38stbFdjabXa/pv4ujbCp6ovRfWXBSX/
         DtBfyzQHxK7tMAw4OaLl66y5WUbfg+7x8L8kiVcfsBQcZDgc/N9wJZWjiFNqUgsdRfrB
         qYG6ButYIjARh6JmT8dHiVC2KnI6zenVdPdJKvfSj+S2b7AzwtLMewG2zTWBpLJBOFtA
         I6Fw==
X-Gm-Message-State: APt69E1dSxP4AZTisIF1YEdV30Ur7tX5Y7hmzVsT4PPNJwkop3DEHMkI
        rkCG3ACXAPmxHvwBdSDvRd4cYzRV
X-Google-Smtp-Source: ADUXVKKB5cYKZuz0YaN1W/k4F/9tyOaEWak0TEYLe1Q2xNI4R1aBb3Dk+vYxA2/juesP111Q0UKW5w==
X-Received: by 2002:a65:5d09:: with SMTP id e9-v6mr4878907pgr.150.1528911519849;
        Wed, 13 Jun 2018 10:38:39 -0700 (PDT)
Received: from JF-EN-C02V905BHTDF.tld ([12.111.169.54])
        by smtp.gmail.com with ESMTPSA id z26-v6sm5858611pfd.60.2018.06.13.10.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:38:39 -0700 (PDT)
Subject: Re: [PATCH 01/13] selinux: Cleanup printk logging in conditional
To:     peter enderborg <peter.enderborg@sony.com>,
        Joe Perches <joe@perches.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-2-peter.enderborg@sony.com>
 <a85d28e8cbd32acda21424ab6a46089f26969671.camel@perches.com>
 <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <b7a048ae-830f-9da0-9548-ea6d34db9756@gmail.com>
Date:   Wed, 13 Jun 2018 10:38:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/18 11:23 PM, peter enderborg wrote:
> On 06/12/2018 04:38 PM, Joe Perches wrote:
>> On Tue, 2018-06-12 at 10:09 +0200, Peter Enderborg wrote:
>>> Replace printk with pr_* to avoid checkpatch warnings.
>> I believe it would be nicer to remove the
>> "SELinux: " prefix embbeded in each format
>> and use a specific
>>
>> #define pr_fmt(fmt) "SELinux: " fmt
>>
>> to automatically prefix these formats.
> I cant argument about that, however some of the warnings and debug prints in this set does not have this
> so it will then change the actual output. (And I also think that they should have a the prefix, but I don't
> know why they don't) So I am not sure if it appropriate for a cleanup patch, it supposed to have no functional change.


I would suggest that could be a follow-up patch.

I do like the cleanup, and it's better than the status quo.

Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>


>>> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
>> []
>>> @@ -96,7 +96,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>>>   	if (new_state != node->cur_state) {
>>>   		node->cur_state = new_state;
>>>   		if (new_state == -1)
>>> -			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
>>> +			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
>>>   		/* turn the rules on or off */
>>>   		for (cur = node->true_list; cur; cur = cur->next) {
>>>   			if (new_state <= 0)
>> So, for instance, this patch could become:
>> (etc and so forth for each patch in this series)
>>
>> ---
>>   security/selinux/ss/conditional.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
>> index c91543a617ac..e96820d92b61 100644
>> --- a/security/selinux/ss/conditional.c
>> +++ b/security/selinux/ss/conditional.c
>> @@ -7,6 +7,8 @@
>>    *	the Free Software Foundation, version 2.
>>    */
>>   
>> +#define pr_fmt(fmt) "SELinux: " fmt
>> +
>>   #include <linux/kernel.h>
>>   #include <linux/errno.h>
>>   #include <linux/string.h>
>> @@ -96,7 +98,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>>   	if (new_state != node->cur_state) {
>>   		node->cur_state = new_state;
>>   		if (new_state == -1)
>> -			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
>> +			pr_err("expression result was undefined - disabling all rules\n");
>>   		/* turn the rules on or off */
>>   		for (cur = node->true_list; cur; cur = cur->next) {
>>   			if (new_state <= 0)
>> @@ -287,7 +289,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   	 */
>>   	if (k->specified & AVTAB_TYPE) {
>>   		if (avtab_search(&p->te_avtab, k)) {
>> -			printk(KERN_ERR "SELinux: type rule already exists outside of a conditional.\n");
>> +			pr_err("type rule already exists outside of a conditional\n");
>>   			goto err;
>>   		}
>>   		/*
>> @@ -302,7 +304,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
>>   			if (node_ptr) {
>>   				if (avtab_search_node_next(node_ptr, k->specified)) {
>> -					printk(KERN_ERR "SELinux: too many conflicting type rules.\n");
>> +					pr_err("too many conflicting type rules\n");
>>   					goto err;
>>   				}
>>   				found = 0;
>> @@ -313,13 +315,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   					}
>>   				}
>>   				if (!found) {
>> -					printk(KERN_ERR "SELinux: conflicting type rules.\n");
>> +					pr_err("conflicting type rules\n");
>>   					goto err;
>>   				}
>>   			}
>>   		} else {
>>   			if (avtab_search(&p->te_cond_avtab, k)) {
>> -				printk(KERN_ERR "SELinux: conflicting type rules when adding type rule for true.\n");
>> +				pr_err("conflicting type rules when adding type rule for true\n");
>>   				goto err;
>>   			}
>>   		}
>> @@ -327,7 +329,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   
>>   	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
>>   	if (!node_ptr) {
>> -		printk(KERN_ERR "SELinux: could not insert rule.\n");
>> +		pr_err("could not insert rule\n");
>>   		rc = -ENOMEM;
>>   		goto err;
>>   	}
>> @@ -387,12 +389,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
>>   static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
>>   {
>>   	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
>> -		printk(KERN_ERR "SELinux: conditional expressions uses unknown operator.\n");
>> +		pr_err("conditional expressions uses unknown operator\n");
>>   		return 0;
>>   	}
>>   
>>   	if (expr->bool > p->p_bools.nprim) {
>> -		printk(KERN_ERR "SELinux: conditional expressions uses unknown bool.\n");
>> +		pr_err("conditional expressions uses unknown bool\n");
>>   		return 0;
>>   	}
>>   	return 1;
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

