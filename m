Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1749C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1221533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dedicatedaccounts.com header.i=@dedicatedaccounts.com header.b="JFVBkWV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF1221533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dedicatedaccounts.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeI0BVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:21:46 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:41679 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeI0BVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:21:46 -0400
Received: by mail-it1-f198.google.com with SMTP id w132-v6so4693976ita.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dedicatedaccounts.com; s=google;
        h=mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=SDGm/iQ4PEHExlRQ1GORupZBmdnFi6azXfNH3QnJquo=;
        b=JFVBkWV8OTpMuvheJqjkXeWErTAf8IWdfGI6ombDYOetUXrNGICgN3hU7iUYDqpwJb
         RPD/sm1w4RfE+3nH9w35Ruz3AMIAAaMTUOvcp5LDO5y5OEyxdsPxNrzBLfwqrvHdR20v
         sp7vaKHRwJcdKgxS2gmW80dO1j4JZXuTZbsVZ0dUSA8xO2QaYTkppeNUoOVzNEd49h8u
         Bvhx+udy+gd0XpPuSgdpHPHXtGWniAhSQxiecSwdBdo8QcBZdW4HP5qBXLXtaXHp3IdZ
         E0Z1UDAKaKNKrLa4zBzhXioW8WUGQ7wkjRr2Y80OvqtXWLRKGOBAYZN37pkmfAZk97w1
         kGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=SDGm/iQ4PEHExlRQ1GORupZBmdnFi6azXfNH3QnJquo=;
        b=nGVgilT/J+eb+ktPgjbKGTyKl9UGn5TLqw/y45k5IhssnuU56c/Dqf1r6XWL4W8Wi2
         n6/HXjDBxdEFv8Oc631hpWBNG3a43KOwnH74PDXRnCajvs4JGUxdEXttMiDPsClWM1RA
         3dPbsvQTgKo2FqxAevup2UqSWED8xJMlOIhasBLDZnnFUAHPfdGlV99NsW5c7RmK2qtv
         FeFZR4f3gTR8osbBXs7wWiUkNuCQSagqwqnlm76u8svVWNWn2CViFsnAFrUaGsPktg4A
         fn1Bqq7zfniq/rg/Sc/W8aKKoKEzXJjTeZXFpMncxTP1S432+bGCYz30c6popdZqcxKB
         7EvA==
X-Gm-Message-State: ABuFfoik+m0Rr0/LVsLxyBnA73AJaCSgF6fN6t53lwwXch+tTUKOTLmo
        rrlgomPN4ZmUl2BpR16LTiUaaoMOsOq0
X-Google-Smtp-Source: ACcGV62eNW9cVjBpOmwuHORlIhixMbP3S71ls3YeOwIccW8sapTf4E6emNfl88xDznq5cNdP4nKb7e4xTA==
MIME-Version: 1.0
X-Received: by 2002:a02:1512:: with SMTP id j18-v6mr2452318jad.17.1537988843650;
 Wed, 26 Sep 2018 12:07:23 -0700 (PDT)
Message-ID: <000000000000b1c6080576caeed9@google.com>
Date:   Wed, 26 Sep 2018 19:07:23 +0000
Subject:  Managed Service Providers & (MSSP's) 
From:   denise.jordan@dedicatedaccounts.com
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCldvdWxkIHlvdSBiZSBpbnRlcmVzdGVkIGluIGFjcXVpcmluZyB0aGUgdXBkYXRl
ZCBhbmQgdmVyaWZpZWQgbWFpbGluZyAgDQphZGRyZXNzIG9mIE1hbmFnZWQgU2VjdXJpdHkgU2Vy
dmljZSBQcm92aWRlcnMgKE1TUHMpPw0KDQpXZSBhbHNvIGhhdmUgZGF0YSBpbnRlbGxpZ2VuY2Ug
b2Y6DQoNCu+BtiAgICAgICAgTWFuYWdlZCBTZWN1cml0eSBTZXJ2aWNlIFByb3ZpZGVycy0gTVNT
UHMNCu+BtiAgICAgICAgVmFsdWUgQWRkZWQgUmVzZWxsZXJzLSBWQVJzDQrvgbYgICAgICAgIElu
ZGVwZW5kZW50IFNvZnR3YXJlIFZlbmRvcnMtIElTVnMNCu+BtiAgICAgICAgU3lzdGVtIEludGVn
cmF0b3JzLSBTSXMNCu+BtiAgICAgICAgVm9JUCBTZXJ2aWNlIFByb3ZpZGVycy4NCu+BtiAgICAg
ICAgVGVsZWNvbW11bmljYXRpb25zIFNlcnZpY2UgUHJvdmlkZXJzIChUU1BzKQ0K74G2ICAgICAg
ICBBcHBsaWNhdGlvbiBTZXJ2aWNlIFByb3ZpZGVycyAoQVNQcykNCu+BtiAgICAgICAgSW50ZXJu
ZXQgU2VydmljZSBQcm92aWRlcnMgKElTUHMpDQrvgbYgICAgICAgIElUIE1hbmFnZWQgU2Vydmlj
ZXMgUHJvdmlkZXJzIChJVE1TUCkNCu+BtiAgICAgICAgU3RvcmFnZSBTZXJ2aWNlIFByb3ZpZGVy
cyAoU1NQcykNCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgaXMgc29tZXRoaW5nIG9mIGlu
dGVyZXN0IHRvIHlvdSBzbyB0aGF0IEkgY2FuICANCnByb3ZpZGUgeW91IHdpdGggZnVydGhlciBp
bmZvcm1hdGlvbi4NCg0KVGhhbmtzLSBEZW5pc2UNCg0KSWYgc2VlIG5vIGludGVyZXN0IHBsZWFz
ZSByZXBseSBObyBOZWVkDQoNCg==
