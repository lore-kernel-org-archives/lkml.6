Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460534-1522281074-2-15817915712411705513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522281073; b=An9jrkBGL4P2iXOJAeCOHfFUXq30/xqe9bH5sxLmDPTDHui
    uxWzUKG9+iJQuZyboyNP9HzywTnRpy9INbEY9+io2oAnwZlJxrpmhqqKF9G1f5Nm
    TuP6fVdV+eu6yrdS8N5JG7vnQMNk3Oc7T0B8FMbTL9kFIr9kYyZHNE+I7taRObEh
    ArNzEu876eSd4746mjvTZiMH/hBQBXMk2X+fu1K5umVb0lJ0GNNu7cBDjdIW6y4/
    W3MdvARHcdx4uR5NFZ3XstmUotOUyywPrsljjJWFzwhmWtITw2NxmSZIkVetaApn
    mEzR7tdoKUaw+3bjdZxh+xGnstdkUfM6oGl/RIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522281073; bh=QYGWkxPQEl02p1zHxpZsA6dk/2
    vs6EN4rOqq3IOKZk8=; b=ZyqoGCt356j50Y4/5bqG+kdyc548Vl0nQL4pWAZq96
    MkDeGqUact64q9mRQZzv5mzEIaCrOlv5UKZOCdMs5S6TFRh0LokfW2NaSiyjOOhc
    hRQteJUqB9FPZL51DxBjdsoHsIh8xERWX1HuWaKV5CBalXJVWvtpCqbl2iHcw2to
    KTGYx1ZEiRPs75ntWkXvwXPJfiOyDuGmMSNlw1DHs0rLxlByI409QeqEyG4dKIjV
    uYX/mK2SYhOti7Rln5Uvrd266zgTG4A9JU4n3we5C3yCSaQIl7WIoXfTKeWYyKgw
    4ZkBgvs27rF3yee+lgpcp+fOAOPhNpt9grtNOSE7WGvg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEoP5yIEJL7+mmubonEYO/+pxt3Emnj0gEuKGFLFZ0Kj/CW75YB29jcY6G7nx8g3fxZD1vZoqCsg3lSNVaWPtAdKFFE/2P49B0hmbzSGb+PS6uwMCxxb
    vApRIw8d7v5IaSX7EDDUcAEdZt+OArHdGPbbDErcMgYQdnYwLFzfEqQYGW/rav9/IdBmFtstAwRyyyCCcjIul/VXMN4MD+w8/zUDsQqcgm5S/BkcEpC3LuKz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=acryCci6UZq6SfNM4M8A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeC1Xu6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:35713 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeC1Xu6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 19:50:58 -0400
Date: Wed, 28 Mar 2018 16:38:34 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        esyr@redhat.com, jannh@google.com, khlebnikov@yandex-team.ru,
        linux-api@vger.kernel.org, serge.hallyn@ubuntu.com,
        linux-kernel@vger.kernel.org, prakash.sangappa@oracle.com,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        oleg@redhat.com, akpm@linux-foundation.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [REVIEW][PATCH 13/11] ipc/smack: Tidy up from the change in type
 of the ipc security hooks
Message-ID: <20180328233834.ceh4xuhiyjnxonic@linux-n805>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <87vadzqqq6.fsf@xmission.com>
 <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
 <877eqejowd.fsf@xmission.com>
 <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
 <87a7v2z2qa.fsf@xmission.com>
 <87vadmobdw.fsf_-_@xmission.com>
 <87y3iikp1y.fsf_-_@xmission.com>
 <80cd2fea-c9a8-4f26-acbb-e0ecb34e4e40@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <80cd2fea-c9a8-4f26-acbb-e0ecb34e4e40@schaufler-ca.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018, Casey Schaufler wrote:

>On 3/23/2018 10:42 PM, Eric W. Biederman wrote:
>> Rename the variables shp, sma, msq to isp. As that is how the code already
>> refers to those variables.
>
>Thanks. It's important to keep the code readable.

Ah great, ignore my last email then.
