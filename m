Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0FECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ABB2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1g36eA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ABB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeGOVJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:09:22 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46258 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:09:22 -0400
Received: by mail-yw0-f193.google.com with SMTP id e23-v6so13022369ywe.13;
        Sun, 15 Jul 2018 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y+v8NlTYgYlb4XZDl+jnCpvB34Puojv/zSBLlDikhtQ=;
        b=dF1g36eAcduBwLO3mnpWOUiQe8eX2fBug5zOy6T5VmrnwD05Dvzn33mJBawIe/2X9F
         kV4jw5/5qAyRl0J999dW10WnpRYXh1taAIDRkgXYAoLMnB06JR5PkSycECdbu8C/DhS8
         Mu6u3M1fx/rK1+pUwpx9GhrAA1vZgiSQuLXjTLtJM65hTTZtTJh4qMnbzkT7CNlj60Y1
         Rnuw9T/9tcs7VUmw2ch6PmNIrk4O4sbsC3I1t4AwW5yezPGelr6oF0Fu7CHHw6xTK34Q
         Z6LmlH4Yt4eF/GvGEqecjXzmcpbJzreQzvoV3qZToHyKV08K9w480uQIcqpBa7ZGlykD
         THsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y+v8NlTYgYlb4XZDl+jnCpvB34Puojv/zSBLlDikhtQ=;
        b=ZvN/fD4fpWz/gGcpzvAVsW641yKqAjw/Ky/4+swSgT4ICPhFhyIjJUjLmuKo7UHDLD
         /0MyW6XNZS2pWKZhJZQ+YVm9jTasQiBseckgwQIHr0TsQl7dN3D3Phf3CRIhFArfv0lk
         ocQ10A2q5Ma248mrmIgV/LvvjIU0IqVGNyQZyxF66W+DXdukhLI2EXwExxkBeZNDPE4B
         cmHhcqeQvo6bE9b7rJoW9j+mfPu17xGNNNFQLEx4VvGsmVQw3n/ydkke3velpQNrRu48
         36f4oPgaUWhVuyPkGKwVgxhyAFgUcbBY5vDvSVOd9We+9Z1/lxtTvwlNy64P0zMy5yZm
         msVg==
X-Gm-Message-State: AOUpUlFvj0VPpdQRyE80DxYpV9yPSM/hpglEYyeg1ENdCuhDU8fdEoPy
        eCUq8ZgaxSQXP+NLxDjgOHI=
X-Google-Smtp-Source: AAOMgpcrE49FIn+pAADuWp5pFN+l0GBDq7DjIaAHBHnma4ASYQfAjsJo7OvJyvinc3lg3odg9IZA7Q==
X-Received: by 2002:a81:8:: with SMTP id 8-v6mr7129978ywa.176.1531687511955;
        Sun, 15 Jul 2018 13:45:11 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2265347ywe.75.2018.07.15.13.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:45:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 03/11] docs: Add Generic Counter interface documentation
Date:   Sun, 15 Jul 2018 16:44:59 -0400
Message-Id: <87ad0f3a4c066049332f9361235b672fec60ed3b.1531685025.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds high-level documentation about the Generic Counter
interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 342 +++++++++++++++++++
 Documentation/driver-api/index.rst           |   1 +
 MAINTAINERS                                  |   1 +
 3 files changed, 344 insertions(+)
 create mode 100644 Documentation/driver-api/generic-counter.rst

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
new file mode 100644
index 000000000000..f51db893f595
--- /dev/null
+++ b/Documentation/driver-api/generic-counter.rst
@@ -0,0 +1,342 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Generic Counter Interface
+=========================
+
+Introduction
+============
+
+Counter devices are prevalent within a diverse spectrum of industries.
+The ubiquitous presence of these devices necessitates a common interface
+and standard of interaction and exposure. This driver API attempts to
+resolve the issue of duplicate code found among existing counter device
+drivers by introducing a generic counter interface for consumption. The
+Generic Counter interface enables drivers to support and expose a common
+set of components and functionality present in counter devices.
+
+Theory
+======
+
+Counter devices can vary greatly in design, but regardless of whether
+some devices are quadrature encoder counters or tally counters, all
+counter devices consist of a core set of components. This core set of
+components, shared by all counter devices, is what forms the essence of
+the Generic Counter interface.
+
+There are three core components to a counter:
+
+* Count:
+  Count data for a set of Signals.
+
+* Signal:
+  Input data that is evaluated by the counter to determine the count
+  data.
+
+* Synapse:
+  The association of a Signal with a respective Count.
+
+COUNT
+-----
+A Count represents the count data for a set of Signals. The Generic
+Counter interface provides the following available count data types:
+
+* COUNT_POSITION:
+  Unsigned integer value representing position.
+
+A Count has a count function mode which represents the update behavior
+for the count data. The Generic Counter interface provides the following
+available count function modes:
+
+* Increase:
+  Accumulated count is incremented.
+
+* Decrease:
+  Accumulated count is decremented.
+
+* Pulse-Direction:
+  Rising edges on signal A updates the respective count. The input level
+  of signal B determines direction.
+
+* Quadrature:
+  A pair of quadrature encoding signals are evaluated to determine
+  position and direction. The following Quadrature modes are available:
+
+  - x1 A:
+    If direction is forward, rising edges on quadrature pair signal A
+    updates the respective count; if the direction is backward, falling
+    edges on quadrature pair signal A updates the respective count.
+    Quadrature encoding determines the direction.
+
+  - x1 B:
+    If direction is forward, rising edges on quadrature pair signal B
+    updates the respective count; if the direction is backward, falling
+    edges on quadrature pair signal B updates the respective count.
+    Quadrature encoding determines the direction.
+
+  - x2 A:
+    Any state transition on quadrature pair signal A updates the
+    respective count. Quadrature encoding determines the direction.
+
+  - x2 B:
+    Any state transition on quadrature pair signal B updates the
+    respective count. Quadrature encoding determines the direction.
+
+  - x4:
+    Any state transition on either quadrature pair signals updates the
+    respective count. Quadrature encoding determines the direction.
+
+A Count has a set of one or more associated Signals.
+
+SIGNAL
+------
+A Signal represents a counter input data; this is the input data that is
+evaluated by the counter to determine the count data; e.g. a quadrature
+signal output line of a rotary encoder. Not all counter devices provide
+user access to the Signal data.
+
+The Generic Counter interface provides the following available signal
+data types for when the Signal data is available for user access:
+
+* SIGNAL_LEVEL:
+  Signal line state level. The following states are possible:
+
+  - SIGNAL_LEVEL_LOW:
+    Signal line is in a low state.
+
+  - SIGNAL_LEVEL_HIGH:
+    Signal line is in a high state.
+
+A Signal may be associated with one or more Counts.
+
+SYNAPSE
+-------
+A Synapse represents the association of a Signal with a respective
+Count. Signal data affects respective Count data, and the Synapse
+represents this relationship.
+
+The Synapse action mode specifies the Signal data condition which
+triggers the respective Count's count function evaluation to update the
+count data. The Generic Counter interface provides the following
+available action modes:
+
+* None:
+  Signal does not trigger the count function. In Pulse-Direction count
+  function mode, this Signal is evaluated as Direction.
+
+* Rising Edge:
+  Low state transitions to high state.
+
+* Falling Edge:
+  High state transitions to low state.
+
+* Both Edges:
+  Any state transition.
+
+A counter is defined as a set of input signals associated with count
+data that are generated by the evaluation of the state of the associated
+input signals as defined by the respective count functions. Within the
+context of the Generic Counter interface, a counter consists of Counts
+each associated with a set of Signals, whose respective Synapse
+instances represent the count function update conditions for the
+associated Counts.
+
+Paradigm
+========
+
+The most basic counter device may be expressed as a single Count
+associated with a single Signal via a single Synapse. Take for example
+a counter device which simply accumulates a count of rising edges on a
+source input line::
+
+                Count                Synapse        Signal
+                -----                -------        ------
+        +---------------------+
+        | Data: Count         |    Rising Edge     ________
+        | Function: Increase  |  <-------------   / Source \
+        |                     |                  ____________
+        +---------------------+
+
+In this example, the Signal is a source input line with a pulsing
+voltage, while the Count is a persistent count value which is repeatedly
+incremented. The Signal is associated with the respective Count via a
+Synapse. The increase function is triggered by the Signal data condition
+specified by the Synapse -- in this case a rising edge condition on the
+voltage input line. In summary, the counter device existence and
+behavior is aptly represented by respective Count, Signal, and Synapse
+components: a rising edge condition triggers an increase function on an
+accumulating count datum.
+
+A counter device is not limited to a single Signal; in fact, in theory
+many Signals may be associated with even a single Count. For example, a
+quadrature encoder counter device can keep track of position based on
+the states of two input lines::
+
+                   Count                 Synapse     Signal
+                   -----                 -------     ------
+        +-------------------------+
+        | Data: Position          |    Both Edges     ___
+        | Function: Quadrature x4 |  <------------   / A \
+        |                         |                 _______
+        |                         |
+        |                         |    Both Edges     ___
+        |                         |  <------------   / B \
+        |                         |                 _______
+        +-------------------------+
+
+In this example, two Signals (quadrature encoder lines A and B) are
+associated with a single Count: a rising or falling edge on either A or
+B triggers the "Quadrature x4" function which determines the direction
+of movement and updates the respective position data. The "Quadrature
+x4" function is likely implemented in the hardware of the quadrature
+encoder counter device; the Count, Signals, and Synapses simply
+represent this hardware behavior and functionality.
+
+Signals associated with the same Count can have differing Synapse action
+mode conditions. For example, a quadrature encoder counter device
+operating in a non-quadrature Pulse-Direction mode could have one input
+line dedicated for movement and a second input line dedicated for
+direction::
+
+                   Count                   Synapse      Signal
+                   -----                   -------      ------
+        +---------------------------+
+        | Data: Position            |    Rising Edge     ___
+        | Function: Pulse-Direction |  <-------------   / A \ (Movement)
+        |                           |                  _______
+        |                           |
+        |                           |       None         ___
+        |                           |  <-------------   / B \ (Direction)
+        |                           |                  _______
+        +---------------------------+
+
+Only Signal A triggers the "Pulse-Direction" update function, but the
+instantaneous state of Signal B is still required in order to know the
+direction so that the position data may be properly updated. Ultimately,
+both Signals are associated with the same Count via two respective
+Synapses, but only one Synapse has an active action mode condition which
+triggers the respective count function while the other is left with a
+"None" condition action mode to indicate its respective Signal's
+availability for state evaluation despite its non-triggering mode.
+
+Keep in mind that the Signal, Synapse, and Count are abstract
+representations which do not need to be closely married to their
+respective physical sources. This allows the user of a counter to
+divorce themselves from the nuances of physical components (such as
+whether an input line is differential or single-ended) and instead focus
+on the core idea of what the data and process represent (e.g. position
+as interpreted from quadrature encoding data).
+
+Userspace Interface
+===================
+
+Several sysfs attributes are generated by the Generic Counter interface,
+and reside under the /sys/bus/counter/devices/counterX directory, where
+counterX refers to the respective counter device. Please see
+Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
+information on each Generic Counter interface sysfs attribute.
+
+Through these sysfs attributes, programs and scripts may interact with
+the Generic Counter paradigm Counts, Signals, and Synapses of respective
+counter devices.
+
+Driver API
+==========
+
+Driver authors may utilize the Generic Counter interface in their code
+by including the include/linux/counter.h header file. This header file
+provides several core data structures, function prototypes, and macros
+for defining a counter device.
+
+.. kernel-doc:: include/linux/counter.h
+   :internal:
+
+.. kernel-doc:: drivers/counter/generic-counter.c
+   :export:
+
+Implementation
+==============
+
+To support a counter device, a driver must first allocate the available
+Counter Signals via counter_signal structures. These Signals should
+be stored as an array and set to the signals array member of an
+allocated counter_device structure before the Counter is registered to
+the system.
+
+Counter Counts may be allocated via counter_count structures, and
+respective Counter Signal associations (Synapses) made via
+counter_synapse structures. Associated counter_synapse structures are
+stored as an array and set to the the synapses array member of the
+respective counter_count structure. These counter_count structures are
+set to the counts array member of an allocated counter_device structure
+before the Counter is registered to the system.
+
+Driver callbacks should be provided to the counter_device structure via
+a constant counter_ops structure in order to communicate with the
+device: to read and write various Signals and Counts, and to set and get
+the "action mode" and "function mode" for various Synapses and Counts
+respectively.
+
+A defined counter_device structure may be registered to the system by
+passing it to the counter_register function, and unregistered by passing
+it to the counter_unregister function. Similarly, the
+devm_counter_register and devm_counter_unregister functions may be used
+if device memory-managed registration is desired.
+
+Extension sysfs attributes can be created for auxiliary functionality
+and data by passing in defined counter_device_ext, counter_count_ext,
+and counter_signal_ext structures. In these cases, the
+counter_device_ext structure is used for global configuration of the
+respective Counter device, while the counter_count_ext and
+counter_signal_ext structures allow for auxiliary exposure and
+configuration of a specific Count or Signal respectively.
+
+Architecture
+============
+
+When the Generic Counter interface counter module is loaded, the
+counter_init function is called which registers a bus_type named
+"counter" to the system. Subsequently, when the module is unloaded, the
+counter_exit function is called which unregisters the bus_type named
+"counter" from the system.
+
+Counter devices are registered to the system via the counter_register
+function, and later removed via the counter_unregister function. The
+counter_register function establishes a unique ID for the Counter
+device and creates a respective sysfs directory, where X is the
+mentioned unique ID:
+
+    /sys/bus/counter/devices/counterX
+
+Sysfs attributes are created within the counterX directory to expose
+functionality, configurations, and data relating to the Counts, Signals,
+and Synapses of the Counter device, as well as options and information
+for the Counter device itself.
+
+Each Signal has a directory created to house its relevant sysfs
+attributes, where Y is the unique ID of the respective Signal:
+
+    /sys/bus/counter/devices/counterX/signalY
+
+Similarly, each Count has a directory created to house its relevant
+sysfs attributes, where Y is the unique ID of the respective Count:
+
+    /sys/bus/counter/devices/counterX/countY
+
+For a more detailed breakdown of the available Generic Counter interface
+sysfs attributes, please refer to the
+Documentation/ABI/testing/sys-bus-counter file.
+
+The Signals and Counts associated with the Counter device are registered
+to the system as well by the counter_register function. The
+signal_read/signal_write driver callbacks are associated with their
+respective Signal attributes, while the count_read/count_write and
+function_get/function_set driver callbacks are associated with their
+respective Count attributes; similarly, the same is true for the
+action_get/action_set driver callbacks and their respective Synapse
+attributes. If a driver callback is left undefined, then the respective
+read/write permission is left disabled for the relevant attributes.
+
+Similarly, extension sysfs attributes are created for the defined
+counter_device_ext, counter_count_ext, and counter_signal_ext
+structures that are passed in.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d9f2f9fe20e..fd8d76fa3760 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -53,6 +53,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   generic-counter
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 46bff1b47d83..08339129d342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3711,6 +3711,7 @@ M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-counter*
+F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
 F:	include/linux/counter_enum.h
-- 
2.18.0

