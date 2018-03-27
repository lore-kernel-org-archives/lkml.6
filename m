Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Qf3GeL9s0/mv0TS+VMGnInbEyWtfAaS8WeeiPNOFIOwgQoLsRtCkjW5OflbaxkShgrnYv
ARC-Seal: i=1; a=rsa-sha256; t=1522168520; cv=none;
        d=google.com; s=arc-20160816;
        b=xXUCIAPP3rusWIYz9fY/1YxammdT8HuWkC9fsWB0Nk9bl9TNp8o/M8oLckjAIRAvOJ
         h5ZpzRLfIj8FZvuyOUhPdu3yNmliBTBfqKpUqCQxi+XiF8gEIkc9BelN8WMI/KKazHgP
         dQL94qHdE/MDKe9ivLyf+MIvusLWFPjOtoIfVMo58vpNrjQfzNzjBH4gNAVDgLKJ+ISd
         XCyv3dY2kWollbV+Q+dpG70T8dH6MwAKwVRq165AdkDH49u/RL5DbFSygDAfIrT8ZqA4
         4dypGsPzAy1zPjc8Ic2v8w9fYa/2vib72YyJdNx1leoM3SegBM+vH5rEPIAl/cmsRHWc
         g1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ftuw+dyomU26zSFy+z3d0MGxeAweaESeZ2dvYzl+M4I=;
        b=cH5pKowfBXuXxZZDUwua0ib3tAI8M9OAZc4r0r7jReGXhl/GMzEzFXGjXE7wyXSLDK
         kY5RbZy+Ob8OGuKPke6H4UqgPqMyMRnazi6YMcjmEtbBwM7p/HS0oJcEslgPMbsTU1/n
         UrIUEU15a+UQLwu1u1ddZeIQsRm9mPt9EX84rm5srm02g8hTjy9GEjIrFPgvmWPimwrT
         xLnuRlYdRAfhBXL6gBU7S1lnMoyZk9ce2cBfifoJNpPu2BMCU0qWEBl9HSRag4Xc+kbx
         uoy/N68KfMpEWmp3qi0jDdlZqa30d9p6xQN4uzGUYJCpEz+fVpVbu7pGPaN0sNPvkNVe
         i2EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 022/101] PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
Date: Tue, 27 Mar 2018 18:26:54 +0200
Message-Id: <20180327162751.346137250@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109005834621477?=
X-GMAIL-MSGID: =?utf-8?q?1596109377810391859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 1903be8222b7c278ca897c129ce477c1dd6403a8 upstream.

The Highpoint RocketRAID 644L uses a Marvel 88SE9235 controller, as with
other Marvel controllers this needs a function 1 DMA alias quirk.

Note the RocketRAID 642L uses the same Marvel 88SE9235 controller and
already is listed with a function 1 DMA alias quirk.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1534106
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3899,6 +3899,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
+			 quirk_dma_func1_alias);
 /* https://bugs.gentoo.org/show_bug.cgi?id=497630 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
 			 PCI_DEVICE_ID_JMICRON_JMB388_ESD,
