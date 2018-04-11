Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2499229-1523454099-2-15308476452021273592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523454099; b=qFzrzx6uLviARcoGyeDXiie8AdUK1nh9pYu04J1a55dlTJ1/lP
    HunLspKeOxKx9prREp8bphLith/lzYyUN188vFL/b8hRlu8mnpweisREY6b3RvjY
    mFbnM6bLCmXQ8Ohwf7FAAengDSGpmFVWnOT0wul4dU/rJ2s4C+u+X4xoEX+rob6S
    VjKWDJ4HSbyoGWQnTn5NTwYJPBQLFcMJufEl+wQfHfcqz+AmXoui46f8hvYM7ApS
    Gd30gIzgxUi75NS6pl1jA0k2FecOMlaLYKO9ONS1EV2oTzB0HBXSbMitR7hytNw0
    p8jzgs2AE+QyvxNReaeuMFP4sIp9R/s2hKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523454099; bh=LK+NcB3oglBuivPnEK5qXl3si1oQgXZMDBthI7T
    Nsc8=; b=tdwhk8KRfy/3pPkVx74Wo5KfuH5l64/voc5l8ZijEOiHARqeb8YmsNB
    8SDEMwyLkmNO5SGIa/n4sHZDnc+aVBdtaUdh96OGlzedRiiOuvMC138yi30lpCLZ
    1IxdBb9DER+ESKyz7mSD4FS3Kx/UDRYcKm7tshlYCgPjmXTUaYgdFfBDHB6aQlsR
    hl22M6lVMtn9JOJHrjNGIOUJErbA9iA0HYiVoIitmNcY3Yn6zHDKk27k/PmEFRPH
    g+0V58Cmrshie9ob3B6m38/PE1BM7m3p2OgcYTz0lE6+empcRr5DBHZHcpl51LmD
    mKJeKgjpJiaj0mtx6d6tTxI0BlTR/7Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAa0U0x9xwPAgNdj15DPkqnDMh4gaV+xG9IrtoHCHBD4jJiUxuxyd3SG/X99DvydwKhuUidxXRhtUDx6LV9kuyYSP5ZJLJ9kaEoGEpIcuqagAxYoB7Gz
    BjLPZDg3XvCjpk9kb5k4s/HkyoBbrwa61cs8k71/sFOZpxXGc7G9815hn2TyFRQ5wdJOuBKo5v3fO9PFsd4Olfl3CxbsW+iXmXIxuejfuWtVJHSWQos8r8Ly
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=NufY4J3AAAAA:8 a=2sMamet3QFHnW295dNwA:9
    a=CjuIK1q_8ugA:10 a=wVgk668jQVoA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=TPcZfFuj8SYsoCJAFAiX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeDKNlg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 09:41:36 -0400
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:51890 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751797AbeDKNlg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 09:41:36 -0400
Date: Wed, 11 Apr 2018 08:41:33 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Pekka Enberg <penberg@iki.fi>
cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] mm, slab: reschedule cache_reap() on the same CPU
In-Reply-To: <71010251-e1bc-e934-cecf-ae37a1cede90@iki.fi>
Message-ID: <alpine.DEB.2.20.1804110841040.3763@nuc-kabylake>
References: <20180410081531.18053-1-vbabka@suse.cz> <20180411070007.32225-1-vbabka@suse.cz> <71010251-e1bc-e934-cecf-ae37a1cede90@iki.fi>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfH6E8AbJEHX6iz0DKDkZdhGP7/bxEvTdfMXIx5zzunFLDVYrVvvVMQiUoUmPWk115YEnlxBje6Pk+xEPrpU0NdWMfl9/8aACysKbOUfM+A8KImoSMho/
 KXPkYw/DnPckDmnSO8h9XxuK764YTWBNjYTh5DvqKDwvFX4Bfe1GvwKdMplBijx5xErTBgh2VMZIZaWwv6SxZuXhpwUYnaIx5CLeem4X90xDogSxyVfvNY4Z
 FOsGEaXLtYiQraOSAy210xfWN54fUtgpFxFtxUcm8NoKVqwCRtDXdzjK7lAmBFEGAWpnwo4+L/XdDxhZjOv/v6qNHPL6N2emU4+afEL8J1YTXN61aVDi+P3h
 LpzsLev+vW+4sH9dZN7stpY2wcQNs7113JVwOxS/WA+BOMD589J9FthDH+pFs15kY93vjXBy5+5TnvgXMRMI/xSYo/MHZmoIHnHZZzyz6wZ0BV1J2nUToDd5
 eOt16FsTkiPtKY/qatSVB6JryEFCbarDxnpNMr73q397NQA+rOpo+RK5NUMbq4mpcOG4hhmIFUyr8upL++/CV1YojvPTCeytHfCUcw==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018, Pekka Enberg wrote:

> Acked-by: Pekka Enberg <penberg@kernel.org>

Good to hear from you again.

Acked-by: Christoph Lameter <cl@linux.com>
