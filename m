Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5DC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36F218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HctFDfQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfAaPt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:49:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45527 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:49:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so1499942pgc.12;
        Thu, 31 Jan 2019 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YjbibIfATA+o+XTsnltHYmkIl5XvdZaaurPfArOK03s=;
        b=HctFDfQHLBHoynvH+zrCmsI5VpRzeuPwxxb0KnFqow4BQwbqcGOoX+S7jzh+5GVzub
         Za1bXwjuEnqzHV+HU/S8IGVzKIt7Cu9wqgG+yxgAgFbpKzWQmFzJUeYwy5iiJ/anZ+1A
         R2Dvs1+jhBBO4MvBDDfdT//FgdIQQ9U2lVR/zaE0LhegjgapF/0Uh4vLryR0wXqpx4iT
         1mWvph3S0hYxsIc8Qda/TXG7WH/VsuHCwyHUWIoBXvO6ta5yGIUV6bFgVppN56tssP4w
         kMhITlUrqXc8kxsV5cORvSRniFNWsXQVKFY8ZlxYObFaZJBJzaiKqk6Kf2aBI5dFQcI/
         xXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjbibIfATA+o+XTsnltHYmkIl5XvdZaaurPfArOK03s=;
        b=WN11iQUhecCrS84R+VBWGtH08rhAmaHD0pt1iFhx8qhR4CHi4JHXizXHFcjeIev/EL
         v5tlQbuhGv+mV8cYopDQCucZS0BmaUYTnHlttB2/Ls7I1nfqViZhXAvCTBRBfKw7uuuo
         bD7cjSV96v6H9CIu0Q99JAoGnhRZyvd0zFMhOTKjUBul3UkVS59PL9TXdTubzyjrI7FT
         hJuJSyJbzqV5hQ3OHOylaqDCX1OAsqS6CjeybU8GZtqdnuiwhEmX0MnJmT7BXeUP4fWZ
         pecsQG1nUcY4W/zzpCSRHGgFOETNHO/1Yvpm7Fmg9J/F4NXsUKn87aK3SAKXV0eGqSIx
         k9oQ==
X-Gm-Message-State: AJcUukd+h5/gg9izOI0OqgHILwL2T3pI1cR14PoaKEIWj9B3mrnDpfre
        chun30++O2sEZwG/DqK7ZOk=
X-Google-Smtp-Source: ALg8bN7iXVmHnltlUs1tIBLCrAthR9u7OBF/3M4knZ+d7XVeSBjzumJhveT3rYgWi0mWKNw3UCZ9Kg==
X-Received: by 2002:a62:1542:: with SMTP id 63mr35512774pfv.230.1548949764138;
        Thu, 31 Jan 2019 07:49:24 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::3977])
        by smtp.gmail.com with ESMTPSA id a15sm6309651pgb.1.2019.01.31.07.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 07:49:23 -0800 (PST)
Date:   Thu, 31 Jan 2019 07:49:16 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: iio: light: Add max44009
Message-ID: <b36579acc3031a28657b6f2e143e9ea4051d7c46.1548947951.git.bobbyeshleman@gmail.com>
References: <01f62d9d67110fd2c2f34e7835973fc6874a9fe8.1548947951.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f62d9d67110fd2c2f34e7835973fc6874a9fe8.1548947951.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bindings for the max44009 light sensor.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
Changes to v4:
- Add subsystem to subject line
- Change node name to be 'light-sensor' 
- Clean up style

Changes to v3:
- None

Changes to v2:
- Clean up style

 .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt

diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
new file mode 100644
index 000000000000..557297c86fba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
@@ -0,0 +1,25 @@
+* MAX44009 Ambient Light Sensor
+
+Required properties:
+
+- compatible: should be "maxim,max44009"
+- reg: the I2C address of the device (default is <0x4a>)
+
+Optional properties:
+
+- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
+  IRQ_TYPE_EDGE_FALLING.
+
+Refer to interrupt-controller/interrupts.txt for generic interrupt client
+node bindings.
+
+Example:
+
+max44009: light-sensor@4a {
+	compatible = "maxim,max44009";
+	reg = <0x4a>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
+
-- 
2.20.1

