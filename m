Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF6C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23C42064E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Dk+Jfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23C42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJNB76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 21:59:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39799 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJNB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 21:59:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so7380312plp.6;
        Sat, 13 Oct 2018 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UfQXMSNisUUKmBzXqUHPaIbusGk3SzE8gAzbgyVuffg=;
        b=q6Dk+Jfd1plcRUVCetPi02VP/EDFJLVNrZvOseo3Eu+4TqZw7tyFy0C5YA3KDrDTgy
         F47EX4H1PP3uo8mx3nn+CUqAY3+H7vpW6/m0+d4w0ERYpwFC3BBpuZFboDjfD6ULU7RL
         vyj/EvbNLINf7hcK7XKT+B74yHSwUxZlDcX3j7SrrgxRWBo7XlZQnyfmA8N8M6zI1/gp
         haVBp1c54mM8RM96DYt5cjsQDqhG+mrVOWUozorp1mUc8mPwX6C1Gup64NECbX5yd0GE
         W1Y7Oe6g+W0JHXbLe1TX2Qka0lurJgkdw6SohVzASsc4gQEeh6jDLNofhRtQ9IE6xb0P
         wjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfQXMSNisUUKmBzXqUHPaIbusGk3SzE8gAzbgyVuffg=;
        b=bHtlNAMOY9Lrcti3bavOl+BuOnSQ3js0e42HV1ADTQFrix80udGafn2v+MsWc1ACXS
         Ek76VM28g29VF5LI5DAeiDlZ+1R5O4lXnLGTM4A/CROsDzDtRBnRWNTsslbCoPrW9DuX
         IcyaavUVx9fCLK85TogsqOd7dC6IPUU/CISHkZy8sIAgx/TZSE18PG97yoKjmJl2uAXz
         tU7r+/HEcc7Gt1+4jJMes23e4WcJe8igHBhf6pqPOr6QSw0HJuYo0OIWS5cxzlI6b09k
         1pZ9RBNMGFDKbSw1O+vwp1y9xpPH/2k67ww0I5lM5CjIx7Et5wicrcZMw1wu/vidqy1T
         i+vw==
X-Gm-Message-State: ABuFfoj3PbL67/o6ld4QgVpBi373aCGGeOKnq+wik2G0SRzcnexa7ksw
        +a3xCrG6saPOjSp1OsZUifw=
X-Google-Smtp-Source: ACcGV62b49HOD9b+By+DkRSbqPTQh8XJfjhdYytcv7JK4I3AmKpoXRS+8vo2n02QqMMIWeiS96ITqw==
X-Received: by 2002:a17:902:89:: with SMTP id a9-v6mr10288718pla.279.1539454908660;
        Sat, 13 Oct 2018 11:21:48 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j5-v6sm6241739pgm.79.2018.10.13.11.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 11:21:48 -0700 (PDT)
Subject: Re: [PATCH v2 12/18] of: overlay: check prevents multiple fragments
 add or delete same node
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
Date:   Sat, 13 Oct 2018 11:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <97b26203e6792795bdc0a66ce4cdb47571ff16c1.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/18 05:51, Joe Perches wrote:
> On Fri, 2018-10-12 at 21:53 -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Multiple overlay fragments adding or deleting the same node is not
>> supported.  Replace code comment of such, with check to detect the
>> attempt and fail the overlay apply.
>>
>> Devicetree unittest where multiple fragments added the same node was
>> added in the previous patch in the series.  After applying this patch
>> the unittest messages will no longer include:
>>
>>    Duplicate name in motor-1, renamed to "controller#1"
>>    OF: overlay: of_overlay_apply() err=0
>>    ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
>>    ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed
>>
>>    ...
>>
>>    ### dt-test ### end of unittest - 210 passed, 1 failed
>>
>> but will instead include:
>>
>>    OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
>>
>>    ...
>>
>>    ### dt-test ### end of unittest - 211 passed, 0 failed
> []
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> []
>> @@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
>>  }
>>  
>>  /**
>> + * check_changeset_dup_add_node() - changeset validation: duplicate add node
>> + * @ovcs:	Overlay changeset
>> + *
>> + * Check changeset @ovcs->cset for multiple add node entries for the same
>> + * node.
>> + *
>> + * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
>> + * invalid overlay in @ovcs->fragments[].
>> + */
>> +static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
>> +{
>> +	struct of_changeset_entry *ce_1, *ce_2;
>> +	char *fn_1, *fn_2;
>> +	int name_match;
>> +
>> +	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>> +
>> +		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
>> +		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
>> +
>> +			ce_2 = ce_1;
>> +			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>> +				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
>> +				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
>> +					/* inexpensive name compare */
>> +					if (!of_node_cmp(ce_1->np->full_name,
>> +					    ce_2->np->full_name)) {
> 
> A bit of odd indentation here.
> This line is normally aligned to the second ( on the line above.

Yes, thanks.


> 
>> +						/* expensive full path name compare */
>> +						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>> +						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> +						name_match = !strcmp(fn_1, fn_2);
>> +						kfree(fn_1);
>> +						kfree(fn_2);
>> +						if (name_match) {
>> +							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>> +							       ce_1->np);
>> +							return -EINVAL;
>> +						}
>> +					}
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Style trivia:
> 
> Using inverted tests and continue would reduce indentation.

Yes, thanks.

-Frank


> 
> 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
> 		if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
> 		    ce_1->action != OF_RECONFIG_DETACH_NODE)
> 			continue;
> 
> 		ce_2 = ce_1;
> 		list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
> 			if (ce_2->action != OF_RECONFIG_ATTACH_NODE &&
> 			    ce_2->action != OF_RECONFIG_DETACH_NODE)
> 				continue;
> 
> 			/* inexpensive name compare */
> 			if (of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
> 				continue;
> 
> 			/* expensive full path name compare */
> 			fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
> 			fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
> 			name_match = !strcmp(fn_1, fn_2);
> 			kfree(fn_1);
> 			kfree(fn_2);
> 			if (name_match) {
> 				pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
> 				       ce_1->np);
> 				return -EINVAL;
> 			}
> 		}
> 	}
> 
> 
> 

