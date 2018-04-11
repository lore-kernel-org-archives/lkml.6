Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476337-2-14997906977606920476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476336; b=DHpX5uFEfFUUUJ2KFzsFs+F0Y4njHYalUI5rGWwNh9y6B31VxJ
    7qeSUwRTof0DRzxlthQn9qqlssuJyDR7Mu0ZJJokQU2PBSja3JB9iKFq+C3VU1id
    ii3WCXMJ5XrwOOocvQicjKMaqj2VZqGfjmZK6/kDw/j8HtMyCianY2h8EhvzC1y8
    0O59a5UluLIbV/juCs8YrGxvuq1NyqsLUkJgo5+YLjorJjSaMfT/47qKi0rSSqnU
    D8/HsnGLkWZCEnRUs5sbPL0pi2AjAgRss7OnsMvSHw+oFezY+Q96mkcDj/5kyxbs
    uyNSCYtVqzhb/rjW1IM43ShXA2sd26SK3BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476336; bh=7cg23ADox2X0C30T+ngd1sxJ+cMb47
    0Y+SNtYoIhPOg=; b=iZDfS8D22n+2RyaMjDQJxnUYe6h2qsnQArUEfkrOZ2k7xl
    X4ObwiM5PIw6KgL/DTKR9Ko4ZAUgYz87mqsvibt4yBUDL15X9rcPmCmamlvZK1I5
    ZvlK/IAgr5n8n/4Qc+EQLtY3zH73ZUKQXYv73IL30Ei+d9oaGUaDwAD6fSwY4vFk
    SsZrFEOdm8px+jZwpFu708XnYGdolMrIlv62jOU6RhAN0m121SbYq3JzbguUXps5
    pEebR1yBySnNejdfqdA8jJf/PQ0/bUt8PErcfGiohGkiJ20urphA/Oosi3I4QOAl
    0CHouMNGfoumgVgBTSJDMQDjrsfJaPYXEt3NjYzg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfP1naq1rGUlSdTM5fN31wUne7hPwaHhPQTorer3AWY9mRJmLKuswxiKCaT+CYXXrFWjLfrPysHBKLekblJOGwCw2m2ZhmxP+TYvHyhniKPfBhMzxXsiy
    skkTGORV2bvcenN2jNdPPD74X5+HrtUZwqcj4l/3+zTM2Ad2grIo0m8Lx3J7bg54vGViABf9Ym2SbWs4webPTVZpMM7U3Epp8GCpUoV7Yz0ME0W1H0tuH1u7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=o4SlnAovBq1H1Z1hcNYA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756565AbeDKTwB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:52:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933903AbeDKS6L (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 126/310] ACPI / video: Default lcd_only to true on Win8-ready and newer machines
Date: Wed, 11 Apr 2018 20:34:25 +0200
Message-Id: <20180411183627.841332635@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 5928c281524fe451114e04f1dfa11246a37e859f ]

We're seeing a lot of bogus backlight interfaces on newer machines without
a LCD such as desktops, servers and HDMI sticks. This causes userspace to
show a non-functional brightness slider in e.g. the GNOME3 system menu,
which is undesirable. And, in general, we should simply just not register
a non functional backlight interface.

Checking the LCD flag causes the bogus acpi_video backlight interfaces to
go away (on the machines this was tested on).

This change sets the lcd_only option by default on any machines which
are Win8-ready, to fix this.

This is not entirely without a risk of regressions, but video_detect.c
already prefers native-backlight interfaces over the acpi_video one
on Win8-ready machines, calling acpi_video_unregister_backlight() as soon
as a native interface shows up. This is done because the ACPI backlight
interface often is broken on Win8-ready machines, because win8 does not
seem to actually use it.

So in practice we already end up not registering the ACPI backlight
interface on (most) Win8-ready machines with a LCD panel, thus this
change does not change anything for (most) machines with a LCD panel
and on machines without a LCD panel we actually don't want to register
any backlight interfaces.

This has been tested on the following machines and fixes a bogus backlight
interface showing up there:
 - Desktop with an Asrock B150M Pro4S/D3 m.b. using i5-6500 builtin gfx
 - Intel Compute Stick STK1AW32SC
 - Meegopad T08 HDMI stick

Bogus backlight interfaces have also been reported on:
 - Desktop with Asus H87I-Plus m.b.
 - Desktop with ASRock B75M-ITX m.b.
 - Desktop with Gigabyte Z87-D3HP m.b.
 - Dell PowerEdge T20 desktop

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1097436
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1133327
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1133329
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1133646
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_video.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -87,8 +87,8 @@ MODULE_PARM_DESC(report_key_events,
 static bool device_id_scheme = false;
 module_param(device_id_scheme, bool, 0444);
 
-static bool only_lcd = false;
-module_param(only_lcd, bool, 0444);
+static int only_lcd = -1;
+module_param(only_lcd, int, 0444);
 
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
@@ -2082,6 +2082,16 @@ int acpi_video_register(void)
 		goto leave;
 	}
 
+	/*
+	 * We're seeing a lot of bogus backlight interfaces on newer machines
+	 * without a LCD such as desktops, servers and HDMI sticks. Checking
+	 * the lcd flag fixes this, so enable this on any machines which are
+	 * win8 ready (where we also prefer the native backlight driver, so
+	 * normally the acpi_video code should not register there anyways).
+	 */
+	if (only_lcd == -1)
+		only_lcd = acpi_osi_is_win8();
+
 	dmi_check_system(video_dmi_table);
 
 	ret = acpi_bus_register_driver(&acpi_video_bus);
