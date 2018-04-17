Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981197-2-15331139383539174286
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
    1523981195; b=YWPfdVtvC2m9ileCD0rnd/lg76sI+xlXd5q7cY3fcj5hbXps+Q
    5AyzAXMagdxGEqp8pjtrXbFpclnLR4q0kSRDvsTKAeFQnP9Fx1gOb05Uj74zCS6m
    gisu4q42wAD4l6DAO62HLhdZhGKez3MetOKwDzfHUCWhkbf12F9FwA6jpVTrNNG7
    J/rGM5yy6v6rtSfvpQ/wCnyfW/ihR4G3xQCZRQiew8M7j//ey65bZ8uvQKDqRxZK
    IpLdVCQyVL2bCJdiT+0ExnXwJLN9Fm4J9+N5e9OCaRFpRzTB1SjG6J/WHAdcjobU
    5+0L3XxuptjZE6BeyeXWu+Um03EFsCz0YFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981195; bh=DxxhmObluMNV2Bk5AG5XoWyMUtqxig
    liUB4+7qTri4w=; b=rMYO2A4r+f8NmlTX7TUpgU9pOv4LWx/7/inGUhdmWb2qn3
    7giHQQ8S1VYSLW1hWQKDj/qi5fQ7wgnRJaH6hakUnl7req1kancblYlC+3Aj74tM
    gaIbk7MN6hS9Oj256vBJ+emUEGOpwVKqEobr63fXBxaXG7lVITV/WDoleErlAenp
    rnwnhhsEzAzQmTfz1fbGsNP5fhcRCeaLWAx3+3AAUadoAB+sYzRYUOIMyjXv4Ujw
    Fz3ZGLiGUbM3C8JmRQkvBzsUnpSNMkOWUwqdkcMsN3Xl/WQXvO/0FAoSaZSWdH51
    5ZdTHXHHDG9h3xYWMjiKWveZuIGO1eSTDx83n7tQ==
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
X-CM-Envelope: MS4wfJRcQ0pUN78Ghgf3HRF/9eZJouZf109D5RoT4mlHr3eFm5MM9IMcSeioBgKxJg8Z/xMTNKozV6dJsScZM3v8VSzkrSdvhLP2rcAjEqGOkuhxlTO4JR/c
    gjFa31LJbRVF6YPMoJAm/mEc4ZJ0W02hUwaxJ1wpKMB+HoijcJr91Mhu2zi1bd5gwOX+W6488OySgntI00XPgAgB+437DbYixFFWXLz8DRDFrypaTCGvOnOn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=danhDmx_AAAA:8 a=VwQbUJbxAAAA:8 a=hBqU3vQJAAAA:8
    a=ag1SF4gXAAAA:8 a=VciTersprhI8DVO6v_wA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=P4VdviVPEcjfz_PVVggX:22 a=AjGcO6oz07-iQ99wixmX:22
    a=WLjMIN4s_96MqnBbPenP:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeDQQGa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:06:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbeDQQG2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:06:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.14 24/49] apparmor: fix display of .ns_name for containers
Date: Tue, 17 Apr 2018 17:59:03 +0200
Message-Id: <20180417155716.178286220@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 040d9e2bce0a5b321c402b79ee43a8e8d2fd3b06 upstream.

The .ns_name should not be virtualized by the current ns view. It
needs to report the ns base name as that is being used during startup
as part of determining apparmor policy namespace support.

BugLink: http://bugs.launchpad.net/bugs/1746463
Fixes: d9f02d9c237aa ("apparmor: fix display of ns name")
Cc: Stable <stable@vger.kernel.org>
Reported-by: Serge Hallyn <serge@hallyn.com>
Tested-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/apparmorfs.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1189,9 +1189,7 @@ static int seq_ns_level_show(struct seq_
 static int seq_ns_name_show(struct seq_file *seq, void *v)
 {
 	struct aa_label *label = begin_current_label_crit_section();
-
-	seq_printf(seq, "%s\n", aa_ns_name(labels_ns(label),
-					   labels_ns(label), true));
+	seq_printf(seq, "%s\n", labels_ns(label)->base.name);
 	end_current_label_crit_section(label);
 
 	return 0;
