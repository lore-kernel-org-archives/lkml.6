Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Tmizq+NClV7HWV7Rj0GXQB85IvJzGtzx6GrnRfOc4rvArTTrr/EXBTmG+PUqDW/1JeKnJ
ARC-Seal: i=1; a=rsa-sha256; t=1519412343; cv=none;
        d=google.com; s=arc-20160816;
        b=LrJi3wZ7wrRVZs8SrZ+tQSCUYNLEMzHcReRGZBQZXFYWmlyDp0aPGd8Zz/Ejyiq4yI
         cWVn0nEuZg/MWY7LrTob2sSmlyDtnlN3ae0FlB4Ln7cULOYIDacAYLMSFdP58DEynSfl
         E70b8/zY5NocKxu1VVGLEoBt1lPr17pdrpgQNOY0XczLZDs94Vt+bTIt8am59nHm2Nz3
         rEet73ZfEvSwGRComDB+AnndXU80k4JpSD9bX0jL4YtnfbiaqV+Vmgca2FWqTuGepoUo
         HlYok3T3OEhMKjcq5kK9U5Pak4UqfzzDmTL3sSgtYZY26rSHLS4N3BUH04B3+HY/32+q
         f+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qnvv1pxVccNLmmEOnaVvrIo+VcxubJ3XAgw5z9G0pKI=;
        b=eEnpmlMZfpdbjaVNgvSDv3fy4YtzyCeocqvxSCRTpQSzDjICgQfk5kz/+316PVd+TM
         yo9Hv8rm0ldbQg+ocL7U+EfOqEEKZFtMNmM42WeJXRNdbeGOOl3EFMb3ZYB9dH/4tAKM
         WtRcPdXLYbYCS8vrDK9kDeVl7eNcZzQYzvi9fsYvGJL7x/M+V2QF36THuAQvq5L1kssS
         BIWDUshGjcN0T+8A6JkrJh4xDyPgqRoU2XZkDVopfYzcYR6Pp1CLYZZvLtOhYIqiMqQC
         ronh1LosYLrgvBvL91EZ0MrQj9D5MMWqeifHIAVFRoRWghCjX5p2utvPnONhoxUtUNbr
         /Kyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.15 27/45] arm64: dts: add #cooling-cells to CPU nodes
Date: Fri, 23 Feb 2018 19:29:06 +0100
Message-Id: <20180223170719.625005019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217717291983488?=
X-GMAIL-MSGID: =?utf-8?q?1593219317095462749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit acbf76ee05067c3942852019993f7beb69a0f45f upstream.

dtc complains about the lack of #coolin-cells properties for the
CPU nodes that are referred to as "cooling-device":

arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])

Apparently this property must be '<2>' to match the binding.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
[arnd: backported to 4.15]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -81,6 +81,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -97,6 +98,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@101 {
