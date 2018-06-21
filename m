Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D012A22395
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj5ECDYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D012A22395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeFUVHa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:07:30 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44147 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933597AbeFUVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:07:27 -0400
Received: by mail-yw0-f196.google.com with SMTP id k18-v6so1661508ywm.11;
        Thu, 21 Jun 2018 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xY0BNZtG/1aImj5tWJHKW+p+nUw+hD+JkZPk1QPsXiA=;
        b=Kj5ECDYZUnedqCl8NjEmIkUejb6lrYYW4jaCoIo+zeqiHIDnHt/7eXMEvAqH0yGK+0
         DwJQWGysHRK4/FPCAiWyg0rGhdLNjDhvnncbB8kxxkCA2a2DGhmLWdtSebClff9UO7ti
         yIdHa6mn+sGAXK9oNVh2dfrfGLQy9LYepfUMiFBBEpLAUxbUZ0hgb3Epp2WFKLacqpnf
         2osjlMz7Mk0Ez07URe21zgKASA8WYv3sJr0dp7RK8f/QSVjgD/tjU3+qeQ/hmr5Wah4x
         15lir0o3fLus2uJ6zRQndXiyvo9mss0ZS+JVPEX8B8599/3F1iAXE3W1NOrqVKqnj5oM
         9RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xY0BNZtG/1aImj5tWJHKW+p+nUw+hD+JkZPk1QPsXiA=;
        b=SL1Js7izyBnCUvDfNJMq+hXtA7MhOGoDJiQxulbvnVFGHlBl6HDPtsFaT3ZrYSVrK5
         Jt9P/q/mzOxWY5tq6VeSw6zk7Ds6pdNkHfp7lZHCzFDEYbmeFlqfhLKi7z3HNnxCoDQl
         GYjMgVWcgeI99lJo6WFpa+pK+C0dw56J4VeLwu2J8fpmEgELZzpgUwHsvm8LzxyelJHI
         vqwqO8OpUBJAwn7CAosYCYhEj2St05iMQF3d9rizPbJJFxqGem6HZG6yH+2e20Tgrc6L
         cJ+HiCShopsgbeTxWIo+1zi45VB47q1kXgx8E21bzp6B+lZvUJcJhPj7TC71/v6FG0BT
         BseQ==
X-Gm-Message-State: APt69E2K9OKCjmRZ0IkzFg9P7VxUbJwB9Q+xHzlC1iV4I94QVlSbIFS0
        CIJXyqEdPgJcfand2EzgZdc=
X-Google-Smtp-Source: ADUXVKK8MSyLWqPUXP9SvOYy8ER+CtWgMvX/ulxv7HTKonoV+2Fp9ssIB5eI9aMJ0vynNPaC40Mg3A==
X-Received: by 2002:a81:ad03:: with SMTP id l3-v6mr13550084ywh.57.1529615245434;
        Thu, 21 Jun 2018 14:07:25 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id n204-v6sm2112885ywb.72.2018.06.21.14.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:07:25 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 02/10] counter: Documentation: Add Generic Counter sysfs documentation
Date:   Thu, 21 Jun 2018 17:07:19 -0400
Message-Id: <27299151c2c7c57e70c49b4f7b794839d00cd750.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the userspace sysfs
attributes of the Generic Counter interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
new file mode 100644
index 000000000000..0bb0dce67bf8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -0,0 +1,230 @@
+What:		/sys/bus/counter/devices/counterX/countY/count
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/countY/ceiling
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value ceiling for Count Y. This is the upper limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/floor
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value floor for Count Y. This is the lower limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count mode for channel Y. The ceiling and floor values for
+		Count Y are used by the count mode where required. The following
+		count modes are available:
+
+		Normal:
+			Counting is continuous in either direction.
+
+		Range Limit:
+			An upper or lower limit is set, mimicking limit switches
+			in the mechanical counterpart. The upper limit is set to
+			the Count Y ceiling value, while the lower limit is set
+			to the Count Y floor value. The counter freezes at
+			count = ceiling when counting up, and at count = floor
+			when counting down. At either of these limits, the
+			counting is resumed only when the count direction is
+			reversed.
+
+		Non-Recycle:
+			The counter is disabled whenever a counter overflow or
+			underflow takes place. The counter is re-enabled when a
+			new count value is loaded to the counter via a preset
+			operation or direct write.
+
+		Modulo-N:
+			A count value boundary is set between the Count Y floor
+			value and the Count Y ceiling value. The counter is
+			reset to the Cunt Y floor value at count = ceiling when
+			counting up, while the counter is set to the Count Y
+			ceiling value at count = floor when counting down; the
+			counter does not freeze at the boundary points, but
+			counts continuously throughout.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
+What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
+What:		/sys/bus/counter/devices/counterX/countY/function_available
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delineated by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/direction
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the count direction of Count
+		Y. Two count directions are available: forward and backward.
+
+		Some counter devices are able to determine the direction of
+		their counting. For example, quadrature encoding counters can
+		determine the direction of movement by evaluating the leading
+		phase of the respective A and B quadrature encoding signals.
+		This attribute exposes such count directions.
+
+What:		/sys/bus/counter/devices/counterX/countY/enable
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter is enabled. Valid attribute values are
+		boolean.
+
+		This attribute is intended to serve as a pause/unpause mechanism
+		for Count Y. Suppose a counter device is used to count the total
+		movement of a conveyor belt: this attribute allows an operator
+		to temporarily pause the counter, service the conveyor belt,
+		and then finally unpause the counter to continue where it had
+		left off.
+
+What:		/sys/bus/counter/devices/counterX/countY/error_noise
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether excessive noise is
+		present at the channel Y counter inputs.
+
+What:		/sys/bus/counter/devices/counterX/countY/function
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y; count function evaluation is
+		triggered by conditions specified by the Count Y signalZ_action
+		attributes. The following count functions are available:
+
+		Increase:
+			Accumulated count is incremented.
+
+		Decrease:
+			Accumulated count is decremented.
+
+		Pulse-Direction:
+			Rising edges on signal A updates the respective count.
+			The input level of signal B determines direction.
+
+		Quadrature x1 A:
+			If direction is forward, rising edges on quadrature pair
+			signal A updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal A
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		Quadrature x1 B:
+			If direction is forward, rising edges on quadrature pair
+			signal B updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal B
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		Quadrature x2 A:
+			Any state transition on quadrature pair signal A updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		Quadrature x2 B:
+			Any state transition on quadrature pair signal B updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		Quadrature x4:
+			Any state transition on either quadrature pair signals
+			updates	the respective count. Quadrature encoding
+			determines the direction.
+
+What:		/sys/bus/counter/devices/counterX/countY/name
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Count Y. If possible, this should match the name of the
+		respective channel as it appears in the device datasheet.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports preset registers -- registers
+		used to load counter channels to a set count upon device-defined
+		preset operation trigger events -- the preset count for channel
+		Y is provided by this attribute.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset_enable
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter preset operation is enabled. Valid
+		attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y. The following action modes are
+		available:
+
+		None:
+			Signal does not trigger the count function. In
+			Pulse-Direction count function mode, this Signal is
+			evaluated as Direction.
+
+		Rising Edge:
+			Low state transitions to high state.
+
+		Falling Edge:
+			High state transitions to low state.
+
+		Both Edges:
+			Any state transition.
+
+What:		/sys/bus/counter/devices/counterX/name
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		the Counter. This should match the name of the device as it
+		appears in its respective datasheet.
+
+What:		/sys/bus/counter/devices/counterX/num_counts
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Counts
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/num_signals
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Signals
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/signalY/signal
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/signalY/name
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y. If possible, this should match the name of the
+		respective signal as it appears in the device datasheet.
diff --git a/MAINTAINERS b/MAINTAINERS
index f6e995c142ed..f8a47fd197a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3692,6 +3692,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	drivers/counter/
 F:	include/linux/counter.h
 
-- 
2.17.1

