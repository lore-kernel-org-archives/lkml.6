Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC713C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9BE21546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9BE21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeI0DU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:20:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33807 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0DU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:20:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id 13-v6so379168ois.1;
        Wed, 26 Sep 2018 14:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KiWzvbbZ5RGKSjw+lLdmMC/8vOrD4PDttEZ/ZF38v3A=;
        b=lKFytnDF7bu8I1XcQ6o/Reu/xXwrMEoXZija3ozQucFIjaQ/rl5aWIIGUxKTqW4o+e
         8fC2OTeRTp3l8cK6z1RbKxG4q3HliS1aD2RhMlqjJ4zjGH6KJTq3Q6jPFl5+QwYkcTxE
         cUUWRLLL94RJB8A8k2jUhUrZrCSgNXQrMLYnkhVuRypdy0qjYbGGu3F++uPAYKeSNOiM
         aXRug4xhzijax7cTKOtC6mCnivn6WzloX76qIwqbv0Fc6q+sDTy5EyaoSPC6mNu7VxLJ
         GWJB1bD04lkRSI/VYMBXnyFlxMYSkxLTbwxFNpCFXz9+h88fbEkAu0h2yW6EVIFAL/W9
         5y/g==
X-Gm-Message-State: ABuFfoi0X+9EqYXnOmYG7UW1eB5U6FjvC1CgEiSsZqM2V7SO1Lc8rNMO
        QZWwCHRmvIxGe4ip5T/En6kUcVTvLw==
X-Google-Smtp-Source: ACcGV63TZZieL+BQHtJrxE/TVz1bJXUPlvO9eaCvtnEHQ9vYjORXStrHaXWrYFw6kUFMYJbY/NvAug==
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr1751136oib.120.1537995939012;
        Wed, 26 Sep 2018 14:05:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a33-v6sm20298otc.79.2018.09.26.14.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:05:38 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:05:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Kalb <Andre.Kalb@sma.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Message-ID: <20180926210537.GA3143@bogus>
References: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
 <c0bcc2c1-3058-db4d-ca4d-4e56c502891b@gmail.com>
 <DB7PR04MB5243B6ADEBCB4B53B5A161F8FC050@DB7PR04MB5243.eurprd04.prod.outlook.com>
 <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
 <DB7PR04MB52433D93A8536DC7F71E169AFC1A0@DB7PR04MB5243.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB52433D93A8536DC7F71E169AFC1A0@DB7PR04MB5243.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:21:27PM +0000, Andre Kalb wrote:
> Hi Rob,
> 
> I have used an other hardware to check the patch. I hope it doesn’t matter. I added few lines at the untitest.c. All existing unittest use an attached sysfs, therefore the bug isn't detectable.

Okay, can you resend both patches in one series rather than pasted in 
here.

Rob
