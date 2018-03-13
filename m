Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXLSyZ83dkSBuIQdCP18rwceqn5it27L5B71Gl8/4bTaHWvfmv5VueUWSeDMuimWpS8UlL
ARC-Seal: i=1; a=rsa-sha256; t=1520955068; cv=none;
        d=google.com; s=arc-20160816;
        b=ObkHzXn/0PLp2kCKAxCexbkDmLeToKmZ10COWCVGjBFk1qE/ovBicnNyph6GCKK4ob
         dBSYF8jPAbnJOdfnI5tchPZj0AxIGAJKCsrWoFqIffTu09mI8zLVxDmcUxJvewtp//Ab
         Mm5CGKzR50MRuILsnH6hPbx6Woc+2PgrTpMAr5uzOnM6PvK+xouEH5hkcgv5YvVFd1Tc
         fKNI2vvwR9+N3Rp8rJUFuJS2sZQcKYPeNYng8X2DixGE/98rbL4vpnAMNf1INdPIR8rK
         Y/eHiJyH+RnWBQAgA8GC4ZKZZTR04WDFlW4c8a9XIHco/bNH12S6bDhx8NIjRodr3jpj
         5tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DDvqicFyPKD1tRLwb75W4QTjs0drqQLbEsDvjo+9f0U=;
        b=rb3qa/HOFLk44c3ZupZ/67YXC/Mp2R7U4JHmB9tWUx0seJoWfmCxPUFGyqKaa+vid/
         rr/D++UmTlKGKzQ9K014NYg4FH/tTH0Pt/UO6If/J2az2t8XgeoC9d4iZsct8A/owlEw
         vZqaijWOojjjwRPxgdMMAlJxuw6mU2CcauULmWIDdTpNdXvdlecJJEEOUV9ey7osVJZQ
         0vG6DcodJNebxM+YPSmMJ8BIesra4UhQVbcLcSxR6u8rJZUiQeB9C/aptM8J4eo+hbTd
         hUAHnIPQ36pQdiCLftj6IWs89/oXTlH9hdTaA4G4xco7PSssNpzZ9Mc3xCyeP6F7GMY+
         u88g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Burton <paul.burton@mips.com>,
	Aleksandar Markovic <aleksandar.markovic@mips.com>,
	Rob Herring <robh@kernel.org>,
	linux-mips@linux-mips.org,
	devicetree@vger.kernel.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 078/146] dt-bindings: Document mti,mips-cpc binding
Date: Tue, 13 Mar 2018 16:24:05 +0100
Message-Id: <20180313152326.796228506@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836982014962493?=
X-GMAIL-MSGID: =?utf-8?q?1594836982014962493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit aece34cd576c7625181b0488a8129c1e165355f7 upstream.

Document a binding for the MIPS Cluster Power Controller (CPC) that
allows the device tree to specify where the CPC registers are located.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/18512/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/power/mti,mips-cpc.txt |    8 ++++++++
 MAINTAINERS                                              |    1 +
 2 files changed, 9 insertions(+)

--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mti,mips-cpc.txt
@@ -0,0 +1,8 @@
+Binding for MIPS Cluster Power Controller (CPC).
+
+This binding allows a system to specify where the CPC registers are
+located.
+
+Required properties:
+compatible : Should be "mti,mips-cpc".
+regs: Should describe the address & size of the CPC register region.
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9107,6 +9107,7 @@ MIPS GENERIC PLATFORM
 M:	Paul Burton <paul.burton@mips.com>
 L:	linux-mips@linux-mips.org
 S:	Supported
+F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
 F:	arch/mips/generic/
 F:	arch/mips/tools/generic-board-config.sh
 
