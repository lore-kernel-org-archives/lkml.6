Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2046117-1524725662-3-10399200871623344642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='ISO-2022-JP'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524725662; b=G1rF3UdX5j3nbJATC3d+MfT0ttoVa7mu18HGPD5gHiCUgOCu+3
    U4ktL79WC5aVf1WoompAec/2y6T7bfDF8wwjiFuTMmGYLq8JWx5OzOiJg7gwHRPM
    WGXo32MsT8fjtxnbzd9xdF60Q50jDJ1dLTFeAr8OdQ8D5v100nZHRzAb0kvvmkTo
    bC5wgdPdSldc/WcY8rpmlqa87iBkPUZKRny3TSG5LV/IwJFfO1VQ8n1DkWxtAkr6
    vq+0tYjEF645l3c+/O0JwaRM4A4/YfXYWgpgbZsciJ8SUwuhMd7d3wxTon2KT56Z
    LhKHRrznufVqN+cDRUjECq4Gp3n7CGUCUefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc
    :mime-version:content-transfer-encoding:date:references
    :content-type:sender:list-id; s=fm2; t=1524725662; bh=1xYDX5XwCs
    Hc0qVop32TNKiijTagYGJKhkQ1TWSIu6c=; b=dquhFKLhV9X47QrQePtXWRgpzQ
    o2TggVoSngClEKYw12e7itx/3WfgcElxhWldeuGJeSQMCIATwkC5cunrgdNvtcl3
    HwgnkBoq7XLtsjrterJnZXpUqZJsoY0LvfKXbQm9g+qA1D5ThxtkBLoarAt4IJJ/
    7z6h59TfEKMdKZ8O5QsmVfkg/dS9PPk8aSaK6lLUAgxuFlKPbyw41Zmo+vXXz/Dm
    +6yIpR8Z8g1l8lzOoTwg4mkEqLAv0DvNy5edAM0CR2GNyd3FU8RXqNi36rrnTeOI
    Wd90kw/i435if/8B47caRyrjVe6uyrv33nCnqzIzV3dNiEDMHhmiZOgKJnkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvhxEEGQUUNK/Fw+lQ6HTx+wRrO96OuIwTsUayA2ntepOwc2wSbo5LQbYLTxt/CLGKHODiE7uhsCjWFZA0w8t1QhfAF+C6aPS5IZtqqnwm6GQHNyT/o
    YwRM2dsjs52iUo+FXIYvKME2heawiDqOpplsWSOReqH/tQVDsuBNTMfQkiPIjUXtC0/NlowuT2OYhDV2gnzZIFPbG0R1NlvA/5nX6qEi9Um1EAEGwEzrMnTc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=ZPSk82zQDygA:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=U36R877yPK3UX2nwRsYA:9 a=UAVRJdkkkM0A:10 a=-FEs8UIgK8oA:10
    a=h9kvygdK89wA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDZGyR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:54:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:28404 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeDZGyP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:54:15 -0400
Message-Id: <201804260653.w3Q6rwVO028104@www262.sakura.ne.jp>
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after the CRNG is fully initialized
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Ingo Molnar <mingo@kernel.org>
Cc: "\"\\\"Theodore Y. Ts\'o\\\"\"" <tytso@mit.edu>,
        gregkh@linuxfoundation.org, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, carnil@debian.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 15:53:58 +0900
References: <20180422135210.432103639@linuxfoundation.org> <20180422135213.491879480@linuxfoundation.org> <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk> <20180423071520.GC28186@kroah.com> <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp> <20180423155637.GB8194@thunk.org> <20180426060434.b7fwrem77ht7n5qa@gmail.com> 
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Oh, pull request was already sent. Should be merged shortly.

https://marc.info/?l=linux-kernel&m=152472466201090&w=2
