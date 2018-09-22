Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86683C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0102154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Gzm9Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0102154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeIVX6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 19:58:20 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:42023 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeIVX6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 19:58:20 -0400
Received: by mail-pl1-f178.google.com with SMTP id x20-v6so1810247pln.9;
        Sat, 22 Sep 2018 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lqP/ScYapj5ZfNKVjpnLFuNrpq7uJNpLbuU2p/3GcmA=;
        b=H3Gzm9PqUGF5ayx+XflYECLGO52qf164vD42x/RFjWemYoE23AKcWM4a0dt91X4ntt
         QQEF87unSzo/fgitsusyazPA43ECiENmAUdpIoJe9v9BSeh/Yh6R8/UAMVghRFOnc+3k
         ricXZvNCdR/qmw33tdaHGkNLTeunth0NB6SfnG7mL/4BO2K9IlWuqkMl17O9fF5kKgVV
         9gDQV88gUnSQFAD/Fi1I34Zwj6C4qO/KUOHiAPdKokeBfA82wDVfaAHJ5KAtyWMuEart
         MsgnVpZWW4EBJNNFfp3/Un6yHhxMxxrTWkbbk23elbbt7Y0LtRUpv0JmGu0w2pQiiPWx
         A0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqP/ScYapj5ZfNKVjpnLFuNrpq7uJNpLbuU2p/3GcmA=;
        b=Gfx0ABhzaY3Xbc1PuzUYFofQXBm4oQWsF/KRw5LdVsZwdcj9pQDjXN4BMj1hLvnTrY
         nBlol8Uezq+g3G9kCL5GoM6Qj/fqKMcF1MCcbMLuJPObdRJfA719Cwi3MFs1Jr7MtAFu
         ktD+Ii65ytGEyzzO2kxJe48QJJISZmAbTNT0sRCQo1aBnSBhR5GpkLndXhRBIY/r2ckI
         iV2jKShQsdF+JqHR04bIRYLP9P780ZTuSB3OggZ4qY/P9aOzN6numoVEPrQQS89sDIt5
         zxyR9qY6TW2cO1gCzo9Aj2RFz01N8mootIdBL28YJzXp+Qwk2UCHxZgMJjmzbSgldS6k
         X4JA==
X-Gm-Message-State: ABuFfohJQW/Dox7sFQEQUxcyVP34qQywx6FKMHIKleaFI/WaADLo/rbh
        whqaBNXG3yuffag/K/6amOU=
X-Google-Smtp-Source: ACcGV630QNCwI1BjY7mYGaeJPT9l8ybAQtSV19gqPONA8taXzhjl9+CAlrbt0hR/C1kIZ7O02nbkrg==
X-Received: by 2002:a17:902:263:: with SMTP id 90-v6mr3505468plc.190.1537639434495;
        Sat, 22 Sep 2018 11:03:54 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id n22-v6sm59896521pfj.68.2018.09.22.11.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:03:54 -0700 (PDT)
Date:   Sat, 22 Sep 2018 11:03:48 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180922180348.GA9092@Asurada>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-2-nicoleotsuka@gmail.com>
 <3c117b80-f671-1e57-6eab-3d9801b4b889@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c117b80-f671-1e57-6eab-3d9801b4b889@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >+2) child nodes
> >+  The names of child nodes should indicate input source names
> >+
> >+  Required properties:
> >+  - input-id: Must be 1, 2 or 3
> >+
> >+  Optional properties:
> >+  - shunt-resistor: Shunt resistor value in micro-Ohm
> >+  - status: Should be "disabled" if no input source
> >+
> >+  Example:
> >+
> >+  input1 {
> >+          input-id = <0x1>;
> >+          status = "disabled";
> >+  };
> >+  VDD_GPU {
> >+          input-id = <0x2>;
> >+          shunt-resistor = <5000>;
> >+  };
> >
> 
> Using child nodes is a good idea. However, you are converting the node name into
> the hwmon 'label' attribute which I can not accept. First, it is undocumented,
> second, it effectively creates an undocumented property (if one wants to configure
> the shunt resistor value, one has to configure a child node which is converted
> into a label), and third, it violates the hwmon ABI ('input1' is not a "hint
> about what this voltage channel is being used for").

Oh. I see the point here now. Then a child name could be just input[123],
and I will add a separate optional child property to indicate the label.

Will fix it in next ver.

Thanks
Nicolin
