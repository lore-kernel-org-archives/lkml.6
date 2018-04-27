Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-380590-1524842263-2-16450639132023335511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524842262; b=fI37YkB9re4E+EHxmSdT9QONf7LEXmdqJw9J+1AalGhw05BYdh
    fOTUKD3mdcdQiLDynaX8b/W9IfbUyU6mLWmAseUFEN+XohN0qroycHXwgCqrzFd9
    dMIEVjOPtTiZEWLY3A05LxAkJZAMpwVS1e6IpyDtiStcte48v75y/yK1joP0ULo2
    U6jdyDQN313cKH89FDu6cfXB12DpP2RwlST6rIcrTDGn/UMevFjkT05JsAiCwmrj
    i4i74kQsNGtB33s0G3dra6Vs0JQ2YYBrPrwJR0B9AGCtLP9MHPIrBqeTlg7tV8ko
    2MGDTEIeh2y5QBIe9hj5c/QCCWXbrRDdAJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524842262; bh=K3auNlLRFXR9bCpHkYZeL1FgAVYcZT
    doEYGUw8TzrrE=; b=gHt9LSfpU3Iq50cu4EtrXUN3LXzCEOnJzrYriR4Z0W5fHZ
    53GI7CzxRMQ+J9OihZFRTaKXcDpfxmd4sZsMFsJcxTERL+s/DBzbOKKsLyIVfNkM
    YhyXsntu2woNnQuWxYcvxqjytLN38DpftsgQLEy8UVAkef36fxlk+8LaMJIKXROl
    PWQbmQPMIcK0I17Z/1ZswLSABMueCJM7KtoP/4EovvzCUxO/gqx92jlTc0n6Plxw
    Z24vJ46u5c9XmB+H0jKl1PTNy6LcTTOmsiJ+JHdduXtAMDJBq9cnC7VE/QV3ySKU
    RgEkLMXgFLLSK9fKOZI25BFATfg6BHQleDEkzsWA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH1tw0ImYh59U5JCSKjlApBm9N/Y3It44ETWgawysqdDoyj2sRZHY2WdeFR+DLmwzuqDHlLWYZm66iDSm+0kfyHRdP/e4qe+YG4YdDVsnbRxdxr6pCs7
    +VFl8IlrwqJTX4PuvT3QXbeSy/uMqRNwV1Ij4FszvwXgw9s6F6CVsZVBXf3ntWmkyHxF7fRRtACHRF8JFJMUN/BH5kewbqTv97lzVpKrsyr+JPAGFstspref
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=V_n-OgjjiNrixysVJeoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeD0PR0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933143AbeD0PRY (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 11:17:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80532188E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 17:17:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
Message-ID: <20180427151715.GA3876@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.428437126@linuxfoundation.org>
 <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 05:10:04PM +0200, Christian Borntraeger wrote:
> 
> 
> On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > 
> > From: Christian Borntraeger <borntraeger@de.ibm.com>

Ick, that is wrong right there, my scripts messed up, this should not
have 2 author lines :(

I'll go look at all of these, odds are it made the same error
everywhere...

As for the backport issues, I'll let Martin deal with those :)

thanks,

greg k-h
