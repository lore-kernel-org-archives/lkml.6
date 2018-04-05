Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709085-1522960379-2-3117378273152244343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522960379; b=ojpwrl3hXWfGTSgBcdQdE4BHrtlskpEC1RxLeBACXiAWB45fHD
    L9ZS4o2ZscG/EobETJWveIUyVBTcEqEkOm2Gcs9LcLNZQY2QEy7NGCYR8fJkhIFL
    9Teyus4VU9ticpkmteV7svbmoXXrfUR1VRVQUwm/4kst1SiEtvFQtSPB/UFbeh5r
    DAbG01P5j06lMmhiiHJCb4EoUjFxEz5UXhHtshNVwWXYLf9fCo22DV9SORC2N9FM
    zrUpS1WkUmQBDjLvq1737K77jj/eAwQ1TvNNLiuiiTbgkxRLwOKgUtFeSSs2W0qB
    /e4nA+Wpyso+wcMcOOFZJG8Lccjc/e8XG6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522960379; bh=BmBOMd6W48mgZSUzfTJdXVpr70Kekx
    /gRN8X7oqa4wM=; b=tZvlE1BUxCIr6WtWbEeHC94fv9mPMhDr08/gxE6Pql/1xl
    B6ghqjtFnzCQ/0lM4b3rEAa9QMhGv7I6rxbo2HRYyNXn1e15V9+Ows4nMahnRTkv
    bZP9qXxECVbx63e9ILDaHdGDcJ5QHbJaqITR0huEkkWV8jnau0EgUXWFV2/Y+AIz
    74yN+/70XjibuOe8aFhsuInJqTsZlhqDsQ/RgPX9dNkCQPkArFrUJyLjUskjHe6y
    ldQAt3Ch70ap9he/k86ehgkPKCs7njz2U+nPU9YLPvYMH6R6/SS7uTjpw0DKB1kt
    38jxJHjaOYtWqAcLEHMeADV5+Pug1kvSrZ3cp8ig==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Z+rSTM+r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UQlLTKUi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Z+rSTM+r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UQlLTKUi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHadg6Zq+QZd36R4xWl4aZJrSHSgdfzLWJUObyEcGoJP+wCbXfx71hkPYVHkSTFj5wgc8mxEARxUXr7Tftc+ZCxVI0l5oPF7QKD80aqmuE1Z4/+EUilx
    ABYkzXpI3QJILOUrc/5JQdaTbs0bCVg6xU+61058AYq5DNEZyB0avkAJW0WqXbZEpA/3xCNqB2BVjTF85x3y3wmzI94Iy1XlXOq6/YkJMLa2es9pb86NRqy/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=zLncjWLdyN0A:10 a=Kd1tUaAdevIA:10 a=dYLSnKoooSGQVNt_zXIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeDEUcq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:32:46 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37544 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeDEUcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 16:32:43 -0400
X-Google-Smtp-Source: AIpwx4+JuFLn6kClsijT9KRom31Jm6+e2sm2y7U03Vn070jsePyTtvMmULO0qRfDjX7utC8D5jFpNw==
Date: Thu, 5 Apr 2018 21:32:39 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
Message-ID: <20180405203239.GA20090@sudip-laptop>
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
 <yq137106mo9.fsf@oracle.com>
 <20180316205559.GA29406@sudip-laptop>
 <yq1y3ir668q.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1y3ir668q.fsf@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Martin,

On Fri, Mar 16, 2018 at 05:49:25PM -0400, Martin K. Petersen wrote:
> 
> Sudip,
> 
> >> Any reason to believe this deficiency is limited to MU01 firmware?
> >
> > Not really. But we also use MG02 firmware and afaik, Micron has
> > confirmed that MG02 is a fixed one.  I have only mentioned MU01 as I
> > know it has the problem.
> 
> Let me ask...

Any reply from Micron yet?

It might be better and safe to blacklist all Micron SSDs except M500DC
and M500IT (with MG02 firmware) until Micron replies.

--
Regards
Sudip                                    
