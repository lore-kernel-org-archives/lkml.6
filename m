Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3223379-1523608307-2-10405218914457408899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523608307; b=hBXd+VxXhhEmaTY8OYh8BVHPlNmg9/XXvtIs/RHe/XRqmVaxVn
    V/5TTLkY2C1rJOvw1IuJPjwXt31i4B8EXj3mZLHx5WbxSUl0oIpq9WurelsLI193
    RUE5urz5zhSS3J9UaWbgjMsw+GDw1KlGSJYlsyT/pTfFsawZMjWi6GIpId7kwchD
    zS+AtW1Ck5EGSMBbAR6IkqNca4OZnYynnYEsaKxeVBLvpeYbMka9L5/GmTgrA83U
    CvooN9TxwxIRRG/QCFJPZCl1YrJE8MfelTiWU1qEIPw43vHmITIlxF/8mT5DVpM7
    WyDNWLyKel2Vriv+hYGnRDP+fQN218RkBrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523608307;
    bh=NR72XZ21wWlWdxLrRGN24VhQ1QKiw/zvfPiin0SRTSI=; b=UtAWt6bEw15u
    NnbxWUiZeY1+wRUkrwQGANlB6R77xbPE84ddxgSoTBvXQzXsTAaMxFDe0gLnCfzm
    DjoPx99R3pYHkTHC60rCuqbjeA5hDXBEhRbWaaPiyLN4J3PNMyJtAfL3v+6H9bnp
    OAICB21ITy3L52yvs9szUbEg8+gmLTYdhCEkcVec6qu/xuq0OYBHVl8jCSbrEwar
    1amANCCgz3wfaRf1/qekFl6zd6UKxuN7R8OxiM953RHqZji5uiX40BoVs2uy5BK8
    ZYcdqM50PO5N4+IfApdVNHvN++U6QDDX8jnb6YHTGZNLwHuwry7LUzlXvLq3rj6X
    oT50V8YOnw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOvBzvN70hVYSn4D9xykw16TOVambaFzjiD9Le4FZ7mUl0gQoEKQH19RNL/4hj1QEj7YbDfGzodSNa8ftUVYn9BWOM+4Sz7qqEy4GSURIOJuT7KtnMGL
    pUaHsGGY6xeyzn6EYl1H1ylEDo4kW8OCoyBn8rs9Ozt1hc7lu0DXaK1Fovp1kTEsYlEoTGbAditaPrIXQSvziJnn6n/J6MGfBm6oD9hg7IlD5M7axBM7SPSe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=dfRfuKr-6qo2v9FbFEoA:9 a=QEXdDO2ut3YA:10 a=VlZU0XKO32wA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeDMIb3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 04:31:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:49371 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbeDMIb1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 13 Apr 2018 04:31:27 -0400
Message-ID: <1523608284.7787.3.camel@suse.de>
Subject: Re: [PATCH v2] block: do not use interruptible wait anywhere
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 13 Apr 2018 10:31:24 +0200
In-Reply-To: <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
         <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alan,

On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
> # dd if=/dev/sda of=/dev/null iflag=direct & \
>   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>   echo mem > /sys/power/state ; \
>   sleep 5; killall dd  # stop after 5 seconds

Can you please also add a regression test to blktests[1] for this?

[1] https://github.com/osandov/blktests

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
