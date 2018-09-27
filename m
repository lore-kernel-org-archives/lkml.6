Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F11216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F11216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeI0VeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:34:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42692 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0VeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:34:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id h26-v6so2886884otl.9;
        Thu, 27 Sep 2018 08:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGwwZPm5WLPYDXFV5cdVZJ7voZo5e5hoQb+hDntem7Y=;
        b=m89lMAgdWWSPCLHQTBep2i+aumrcDEo7lSIiVvJcjWnmslRkYkfofEBr4G+/xM3kGA
         tGNtUiwma9v8bVuS2oa146ZCDMrKhuBj4XLTl3RXL1A8JUHpBfUNGHV+0wfVRiMwl6u4
         RuuxxVuC5nxwam3MKiJ+2GgrrWjCz5xxU1G2rMihKckcJYbdU0iFkA8AuydCvH5X61hf
         NwMpKACPgeQAxMF4OIUSIQ51BKrLf0e3wYscSZYyl7CBX22BWkFK//L1BmusZHpUdNqH
         qMFRhAOxYZbBkgdeT/C9QTVkdThH7MDFjNYIcKTgjUvkJ7l1orgGhMj1L+kIqsPHE/pt
         0NhA==
X-Gm-Message-State: ABuFfojXiLyqt88CW68IfzvPDjt+iwN5a4eADd1Z1oTHM69vrYPqBDV0
        cnJafWd0TSoy9H2gkUDxZhuQoJvt8w==
X-Google-Smtp-Source: ACcGV61ZWH3WKzRbd05MtOdnogHcxKTDl5kseE6Cw9w2QB+ROHhooA+dhK1d7iVPUNi0rgmTp39oCg==
X-Received: by 2002:a9d:454c:: with SMTP id p12-v6mr7139515oti.105.1538061326125;
        Thu, 27 Sep 2018 08:15:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 19-v6sm740736oty.16.2018.09.27.08.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:15:25 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:15:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH v8 07/12] dt-bindings: mfd: Add a document for PECI
 client MFD
Message-ID: <20180927151524.GA16798@bogus>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-8-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918215124.14003-8-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 14:51:19 -0700, Jae Hyun Yoo wrote:
> This commit adds a dt-bindings document for PECI client MFD.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  .../bindings/mfd/intel-peci-client.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
