Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472451-2-1244603341686628490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472450; b=M88/OGJBaSBMacnpOkcmJd4Nb+0Sc4WnnAqtt33+KUDRuTO97m
    95yQLGP1XJAPiPgGuddkGyFL7n/hmm/uqO58aVv8GMxk/kmu3DRBdTFSojZUzLlg
    AxxR1aa0qxJDyLALDYItUongY+uz8JDhZqRA8cXcugLVJOWWay8h4uONI9zDDfN9
    kGpMaNXduollmv2KJHmgyP326r/jeoYpYJSNpimciPPn2nSKvmjzq2cYjGGAVKCd
    XL4ervtdg5GMg33SY4norBQsxAIuHC47YjHHT/KsrXt+G4OOI7gBWYSZR2mibLX6
    C2fVkEPn9Z7zoJ0SjAaM5H+XwHxrxyUQYZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472450; bh=LiAgvhXV+z4nmEWf3k0vV5pihcZZrq
    aMbybkYpnJyt8=; b=s3ntRTdczyd+4DoGAOrkHaDC2lQG7W9YvS6jkRapaZhjqy
    PRlEWBDNrmI6f9Dx+7Os2zs64bm4+vNzXZNQ+DrOda7x/EneavXJ7qPfOHdsgNZq
    69vzmtgzcCU15wK5ZbriWQPGFz/RRdDvXfzdpWorxo2F3b3y/tzsH4mTyu8CUCRN
    vDnUrwMny4ajXJi0q2UNAIoZZ86W5jDzfZwBvbMgHkDJ0PZvJrrZ/uNz67BxVZZJ
    PMeobrM3OwXBSTJI1ePIGzT37A8WnAOH1dzS8PoWwp3V72eih6/8djgmtYofwfAW
    6SBejaT3rsWOy6tefwrv0eqGn7dEXmpB+SKbCRsw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDsHPJSsy+WQ2ouC+2xiZVnIsgBQNiRS3byAAhmmKLjPcpDmp6+47Y1+C7zMFcmEoo3WTiu44KdJUxuCKRneRdXcsOb4xEShpzW+nL33GxG3EnX5KdMd
    jwXbpL2e4tvpqsR9qxvfuAd0YU4v33aeIW2QXENyhUdAeXpt54wr7/ZTn7zIJDhobx9jlalHDGHQnb8v2JFbCwnm0Hfw8WiLsy7nql5sWZ+SRSjeJcqqNNik
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=MGgcyyW3LyQtYNGPhRwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755896AbeDKSrY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755889AbeDKSrU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 088/190] ASoC: Intel: cht_bsw_rt5645: Analog Mic support
Date: Wed, 11 Apr 2018 20:35:34 +0200
Message-Id: <20180411183555.769950739@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit b70b309950418437bbd2a30afd169c4f09dee3e5 ]

Various Cherry Trail boards with a rt5645 codec have an analog mic
connected to IN2P + IN2N. The mic on this boards also needs micbias to
be enabled, on some boards micbias1 is used and on others micbias2, so
we enable both.

This commit adds a new "Int Analog Mic" DAPM widget for this, so that we
do not end up enabling micbias on boards with a digital mic which uses
the already present "Int Mic" widget. Some existing UCM files already
refer to "Int Mic" for their "Internal Analog Microphones" SectionDevice,
but these don't work anyways since they enable the RECMIX BST1 Switch
instead of the BST2 switch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -96,6 +96,7 @@ static const struct snd_soc_dapm_widget
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Analog Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_POST_PMD),
@@ -106,6 +107,8 @@ static const struct snd_soc_dapm_route c
 	{"IN1N", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Int Mic"},
 	{"DMIC R1", NULL, "Int Mic"},
+	{"IN2P", NULL, "Int Analog Mic"},
+	{"IN2N", NULL, "Int Analog Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Ext Spk", NULL, "SPOL"},
@@ -119,6 +122,9 @@ static const struct snd_soc_dapm_route c
 	{"Headphone", NULL, "Platform Clock"},
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Int Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "micbias1"},
+	{"Int Analog Mic", NULL, "micbias2"},
 	{"Ext Spk", NULL, "Platform Clock"},
 };
 
@@ -147,6 +153,7 @@ static const struct snd_kcontrol_new cht
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Analog Mic"),
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
 
