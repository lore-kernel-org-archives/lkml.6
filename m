Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2621BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FE4208E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FE4208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbeHGUFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:05:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53052 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbeHGUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:05:04 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so23220001itf.2;
        Tue, 07 Aug 2018 10:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3s0OUp6tn9JaNSvRdWWKVaJmRJm59f/VqxOCJhGBF6g=;
        b=SEXJjMpyEOTS+STs8TC42H0BcHF6f0haSRx8B1TWDnk0lgeM6Eo6qjVwaYO2DsY8zI
         Zmse2EDRDqXxMn27Pn4f3IV3bmuWcpMvVqXvTbshQ8F5jDPQDQINdyF/aHF8k7cbkmAl
         mkqiyLnFjwctsnUZL1P3ARmsDkhtBPDA472t/YaqhKrvMeqh86D0HznG1TR0bQDUYdck
         kHOJDSvfCs/6KmVl4uwANYhfYxyjOcYDXOEQCsiTLUFjgWaR0FAp7j0eAnQHo+eFpLOb
         ciEALTPiL3auqCVSV8b+41edj4wdRIvnFMoOSkkKl2Ua82ZB/i/Ow6/DuFxIZmx3BQj2
         5IEw==
X-Gm-Message-State: AOUpUlHSGDPKqfnLahTtulfwEcieFw4VS28BgOcmt62ZnLJAuQ2rhNow
        3Kn0vhRRb0rQqnxrhTeHrg==
X-Google-Smtp-Source: AA+uWPwTzNJDy9eT11tJ8QmmS4WbDlbwINHVuDwoZkfIWrVD6lfGAc003swA9nohaWBfLByhmMMnmg==
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr2737452itc.16.1533664177023;
        Tue, 07 Aug 2018 10:49:37 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id j78-v6sm1095552itj.44.2018.08.07.10.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:49:36 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:49:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt-bindings: phy-qcom-ipq4019-usb: add binding
 document
Message-ID: <20180807174935.GA18858@rob-hp-laptop>
References: <20180801104941.29432-1-john@phrozen.org>
 <20180801104941.29432-2-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801104941.29432-2-john@phrozen.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:49:39PM +0200, John Crispin wrote:
> This patch adds the binding documentation for the HS/SS USB PHY found
> inside Qualcomm Dakota SoCs.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../bindings/phy/phy-qcom-ipq4019-usb.txt           | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt

Reviewed-by: Rob Herring <robh@kernel.org>
