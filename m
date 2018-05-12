Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZqYjoJcxBb9iPun++UmiEST0FzH+9rqbVRjpE2TmfvB2R16j8nJLyiyp1D3ZXPvGz/3QEuf
ARC-Seal: i=1; a=rsa-sha256; t=1526114793; cv=none;
        d=google.com; s=arc-20160816;
        b=f0Sgsph86d835CfmrjboDPwnFXZV9qTXjdPwpnxHS3W7kmT5qO0ZdFeME2Zz4gpsAR
         LBo4Ik/p6uMTev1joRkkq9jbeh7R9SaXSbQThh2eCxILUesppCrirquWCI4EOUZ5fOcc
         luPhqePj51TV9C3OyiOshYM/oFA0OTEb0ijSxRGLaezp2zhx+/Qo9crtg4xAUxo0etaX
         Tk4GqJkOpdjvaYQBeTUdAuSeYCfXp3wpCZzUoRgJYyX98bE/KJ3GFbKGEEeAfNbilDG2
         pDwgBYkkEuVsH+S3vWwqYxFlqubeXxo8BdZ5+hMlLD+ZiGwtTWvvdpyisEXugiQZAseD
         vcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=x8fFE/f61fdrZ3de3zvCfc80wEM+7QpulNTfs1tZsJM=;
        b=tcNeSJdBeAK7Fd5q89tg9bKs80FNaKTrgDGhqNE3iHTluvzV3HTflALZeRz5WZ5B4R
         +/B4bYzsek5GGV41QuKog28E2jTJEZ3Z94C26fPUq+I7f2Kiyw4qluWm9RgNu2bn+dk7
         i4D9tmpkEjHdj1sK7sZmylmJTNrJCNwYByGx08mZrdmmhlmhqVHW1GUqs9K1QRB04P1I
         bcrKWVns1DYKLcl7I2VbsRQklCJRiIF0Jet/uLzK/N/+Om8DLcyPslpy1CJclqsrUYSx
         9WPXcE+hbDSP4GQx7d92sopoCNFSMV50+dFy2O0/kGsvCiX70tLYfLDcfBd4HLO05N9J
         u0Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	jasowang@redhat.com,
	vkuznets@redhat.com
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	stable@vger.kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] doc: fix sysfs ABI documentation
Date: Sat, 12 May 2018 01:45:29 -0700
Message-Id: <20180512084529.441-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfN7RIVKdOk8Ll/xoTQkO5phkC4ZMfxBj5v8fQtrDmrVtU7WtO1nCXCm+GJp4eU97qD9PO0lrm7bXroFQj+ekrcIGgMlU1K1ns6HH822xp9fE+vlThPph
 aUoQUd9lwiERfySNS6YxgK+SsVBpfln9bDQ7ZwcATcolYsFQQ1vgH79KOJOowmh33QQIqr0gBWUrCw58XUK3OoAUYmcDNhlv/y68MsEotoR9mQ3JoBrXWJOz
 evyC+mjg0Emx487QseFW545hBBdA3XHREhR8CUnR3te4gMg1qEO/5Zfeaw2VVU9RqFjoKnyJ+5E4oV7aPfcVChUZY5vtCYRs3lZzAHfOZZaOgMsuJbM4PViZ
 +2dTUxMv43rzO5iYs3ISDVaJCBqodnLBLzLXUhVGTbDDpEVmCH/T62t/j/rfn33ZCB7ns4PUEC/Ssl1J5U8w+jx3AfZH57bRDlAm9UZecS8GgPCTtMrJCEWk
 wDV2fYa88qUYGhOF6sRcgxRLMZkwkrBu8zcdpCOZG5T6daI1ELNJh433oWn+tbzMWkW1FaJMFxmu2ynmbMwF+LyWhrZwUyotCIXKrg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600247345352561664?=
X-GMAIL-MSGID: =?utf-8?q?1600247345352561664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

In 4.9 kernel, the sysfs files for Hyper-V VMBus changed name but
the documentation files were not updated. The current sysfs file
names are /sys/bus/vmbus/devices/<UUID>/...

See commit 9a56e5d6a0ba ("Drivers: hv: make VMBus bus ids persistent")
and commit f6b2db084b65 ("vmbus: make sysfs names consistent with PCI")

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 Documentation/ABI/stable/sysfs-bus-vmbus | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 0c9d9dcd2151..3eaffbb2d468 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -1,25 +1,25 @@
-What:		/sys/bus/vmbus/devices/vmbus_*/id
+What:		/sys/bus/vmbus/devices/<UUID>/id
 Date:		Jul 2009
 KernelVersion:	2.6.31
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The VMBus child_relid of the device's primary channel
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/class_id
+What:		/sys/bus/vmbus/devices/<UUID>/class_id
 Date:		Jul 2009
 KernelVersion:	2.6.31
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The VMBus interface type GUID of the device
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/device_id
+What:		/sys/bus/vmbus/devices/<UUID>/device_id
 Date:		Jul 2009
 KernelVersion:	2.6.31
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The VMBus interface instance GUID of the device
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channel_vp_mapping
+What:		/sys/bus/vmbus/devices/<UUID>/channel_vp_mapping
 Date:		Jul 2015
 KernelVersion:	4.2.0
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
@@ -28,112 +28,112 @@ Description:	The mapping of which primary/sub channels are bound to which
 		Format: <channel's child_relid:the bound cpu's number>
 Users:		tools/hv/lsvmbus
 
-What:		/sys/bus/vmbus/devices/vmbus_*/device
+What:		/sys/bus/vmbus/devices/<UUID>/device
 Date:		Dec. 2015
 KernelVersion:	4.5
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The 16 bit device ID of the device
 Users:		tools/hv/lsvmbus and user level RDMA libraries
 
-What:		/sys/bus/vmbus/devices/vmbus_*/vendor
+What:		/sys/bus/vmbus/devices/<UUID>/vendor
 Date:		Dec. 2015
 KernelVersion:	4.5
 Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The 16 bit vendor ID of the device
 Users:		tools/hv/lsvmbus and user level RDMA libraries
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Directory for per-channel information
 		NN is the VMBUS relid associtated with the channel.
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/cpu
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	VCPU (sub)channel is affinitized to
 Users:		tools/hv/lsvmbus and other debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/cpu
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	VCPU (sub)channel is affinitized to
 Users:		tools/hv/lsvmbus and other debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/in_mask
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/in_mask
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Host to guest channel interrupt mask
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/latency
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/latency
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Channel signaling latency
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/out_mask
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/out_mask
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Guest to host channel interrupt mask
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/pending
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/pending
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Channel interrupt pending state
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/read_avail
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/read_avail
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Bytes available to read
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/write_avail
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/write_avail
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Bytes available to write
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/events
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/events
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Number of times we have signaled the host
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/interrupts
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/interrupts
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Number of times we have taken an interrupt (incoming)
 Users:		Debugging tools
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/subchannel_id
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/subchannel_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Subchannel ID associated with VMBUS channel
 Users:		Debugging tools and userspace drivers
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/monitor_id
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/monitor_id
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Monitor bit associated with channel
 Users:		Debugging tools and userspace drivers
 
-What:		/sys/bus/vmbus/devices/vmbus_*/channels/NN/ring
+What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
 Date:		January. 2018
 KernelVersion:	4.16
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-- 
2.15.1
