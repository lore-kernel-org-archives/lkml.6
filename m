Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2055735-1523976235-2-13167627528495392275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523976234; b=mYJN3SNl7s/bg56I5Uv+JKWGNeBajglQg+nTumTLYcQXcQseB9
    ILMRu0OVckvsv8oYxTh3ZnzEtG7urV6qyA5mz3G+PV3HWEMmWhmLD31JOVvRlOxY
    ABZQ5sp5oU5kfD/wW2xSrAm/EDa7Y7bi+bkjje/FhTtUY43Dn2b0Ryz5jLl7V34v
    90WT293zVE++G33zUe1ctirfJjHKn1Bu8XLp5NAED6shH3lMW/XrPCafeZh6ed/4
    PniehR5L+iHv3SQq0BqCr4sZfvUW3AgBJE85dyW+UvocW2zFJWwXyfPAzSYyR/J9
    XdwcS1yWWic8LTKk56Zd8VPleYT5/Pc7cmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523976234;
    bh=I6YbRpCqPwYy+DGJYwvZ7aqUlPxFK6NgIXcBmGsoj+E=; b=FvcLykJHaca8
    ZCpkVPiFa0Vqf5Gbg7z3EbTkBfm7pFS2WR6jZKz5UqgzbW/rjewuztYg8hA4Udlq
    gkNepoFpHb55Gv2niVTdGAnsl9cAKzVLilP7W7qpzzYpfA1cG3khj6romy9aMdx8
    3sTpRLOVg+2clfY1wBgwWu6w4NE+ZSFhsK1IME8zIWHeA27fFoi3Hc14Z4CdcYtH
    bu2zPebN6s+141TiolJvVgaEg4Lc/57zN6N2mSpGDacDTqxb8HShtto9M+B5z0Mz
    UOLPeQdpsYrgq1MZN+Veo2VVXDLq7JUp2JsBmQQper8PnKP+Ue5SbhjEIJGH3IHw
    8BOxMfKOqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=P4UroZDU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=P4UroZDU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL73/1ckyLZcZXShYhWwlb/smaDpRa1OQ7dMfBJiGOmVaMdh9Bp2j2Ownc7W6CxGCHb1sl1wNbFGF6wQf+o+4xKKPsNTWNQht116Rf0YURD02giJfXrS
    ImAPw4FPHMTqx1LosXhfBobMkyP/gii39jOiVy/Wa4td9MVyeEGlSASldluZNjmS9mTz4ivBhdwb4vxHdy03DQKMSSdqV/+lAk4HuuqEV5gz9eYlg9aWjMnR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zZ8NKYtTlkQRTRSsIFAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeDQOn0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 10:43:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51602 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeDQOec (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 10:34:32 -0400
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
        ming.lei@redhat.com, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
 <2612135.Ur0PZolWSD@merkaba>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
Date: Tue, 17 Apr 2018 22:34:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2612135.Ur0PZolWSD@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170132
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Martin

On 04/17/2018 08:10 PM, Martin Steigerwald wrote:
> For testing it I add it to 4.16.2 with the patches I have already?

You could try to only apply this patch to have a test. :)

> 
> - '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
> request.mbox'
> 
> - '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
> rcu_read_{lock,unlock}().mbox'
> 
> - '[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s 
> timeout isn'\''t handled.mbox'
> 
> - '[PATCH V4 2_2] blk-mq_fix race between complete and 
> BLK_EH_RESET_TIMER.mbox


Thanks
Jianchao
