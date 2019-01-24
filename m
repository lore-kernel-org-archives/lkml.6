Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF94C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1699218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfAXE0c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:26:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40494 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAXE0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:26:32 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gmWb0-0001h8-BR
        for linux-kernel@vger.kernel.org; Thu, 24 Jan 2019 04:26:30 +0000
Received: by mail-pl1-f197.google.com with SMTP id g13so3071982plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3tL670mpbyCArJnbJPmRxRiUDhed8rW5GibFNIUDKig=;
        b=TfKsC1jdbweUWZHy0XB991rGP85iZTM2L8EWftVq+4FEjgXFIJK/rjmTpWWwo/UtMp
         HyN5pYdMKpgjj0BaWViOtAMN/H+m9oc2NKG+dD29Xv3WqFDyjw13hFJHLEMqLYMnc6n7
         WtT5Y2QmTYFPw8EgXIYJvhADZr38kN8fzx5RrCaBuNLNZkTFPl6azy4MSP6ys56SAX2p
         nFas4cLTr9HSvmKgoqeE92ZPZQY5HEdcFMpyg4VxCt61STPIMyjxq/2uZvpBX728nnf5
         Nofx0gm3jFHHg7r2A8hbXJ13tCc5EIr5n2js6owt+vfB1broGvmUOcktQ+DEGfsuAznu
         +wZA==
X-Gm-Message-State: AJcUukfpU+L/xTAcB3PSjeQLiKezNHkPM+RKguMGtYfDGMpYVN0he0+Q
        4YE5RNoKbtN4D2FrSTGJ2OuNzaCGEhpDs900KzlnBQE/20pQIdN5s49VDdwTp5tcHGgPzTvPgsb
        7EaGjYKTa2IdFINSrMRb7vtTw57aYcH257gNcwl+5NQ==
X-Received: by 2002:a63:4745:: with SMTP id w5mr4641177pgk.377.1548303988949;
        Wed, 23 Jan 2019 20:26:28 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5o4FXmmrBlI0sCAnS43RdZgZeVY3R7sg449HuJhAAgjuytVtlmxtExLzqB2ITmWgqhdFBk6A==
X-Received: by 2002:a63:4745:: with SMTP id w5mr4641157pgk.377.1548303988530;
        Wed, 23 Jan 2019 20:26:28 -0800 (PST)
Received: from 2001-b011-380f-13aa-18a3-1f83-e8c3-1f13.dynamic-ip6.hinet.net (2001-b011-380f-13aa-18a3-1f83-e8c3-1f13.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:18a3:1f83:e8c3:1f13])
        by smtp.gmail.com with ESMTPSA id n70sm32676397pfi.185.2019.01.23.20.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 20:26:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <ecb5ecad-7141-b8db-74dc-a53f2a17301c@amd.com>
Date:   Thu, 24 Jan 2019 12:26:24 +0800
Cc:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Elie Morisse <syniurge@gmail.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <86BE166C-0821-4E16-AE72-728752654C20@canonical.com>
References: <20181226232258.GA23526@syn-yoga530>
 <ecb5ecad-7141-b8db-74dc-a53f2a17301c@amd.com>
To:     Wolfram Sang <wsa@the-dreams.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

> On Dec 31, 2018, at 22:36, Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com> wrote:
> 
> Hi Elie,
> 
> 
> On 12/27/2018 4:52 AM, Elie Morisse wrote:

[snipped]

> 
> Looks ok for me

With Shah’s blessing, is it possible to merge this patch to your -next tree?

Kai-Heng

> 
> Thanks
> Nehal Shah

