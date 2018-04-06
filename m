Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1491530-1523022543-2-2960537771099771157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022542; b=Tq2w1Ek+KZXtulUdThsjo4ABSSMHqxlHVrgUzK1T9tDmUcBXGs
    r6cODG4xcDrt6YKT0xtS/JenMmLqqxvtINdJtfYbF0d4g3jyVnBK89sGVJU9fa7J
    l3ake1skh4PJvZ2KGWxARLQZgzomSXOr+hRfyrkICJ1FWbS0RJoRGOGgHUTjqgH9
    cuVsX/pS2Sty/rhhcBGJ7h/q+tsQ13fz5QbleNBCcnMTyQQ8yceoG5os1d8fK0It
    b7+MIx1kYSQH/s3LtjmpjBu8a7U9BL2ZyxDM+GY5ywAzyxF0JHerTwsQMNBIo0xY
    hcRVCc8S5dWCiFnRXhtprMAenK2SGHRYXD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022542; bh=NdStVkWQYt6gEH2B+3geUk2s7qcqqe
    Qf+qKeMtV9/BI=; b=jHudHRPPp9zMPB6um3VL0o0OxH66wLKTv1oaxZXj5rHdQt
    BwVu+E9I3vYOoEQwM8rXKVcSUgnVcVTIDgVN13zOgtQP2T1tYAUH206pVxrfln+9
    jKaIHfTsyGr3NoumrpPb1x37Zf5goL0yzg/Tb7wRhFpnUv3RtNhIHihHnt1DrXvr
    0Q0eCFQ1/XpmK2lBSMenMU9QkDCkzSbg4wj9yMNGEBW8fszu+d7uS+NH/4S+MViN
    Vq3y92KfeAmAX8dbh+cmFDuXTyWajhwMOcA1x2opXoz9ZjGPTgh3kkQtAiWBBIhA
    4LGgE6OOmo2Eb3Mgvk0zLgvAl/uBiGtCxBL+IhOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNczg0JIqpXb1hGQMO/vZpp5PWyfzweORVUTL+je86pwRtqKorLsBh3PcnkRLd/Cx+6is/4c4pOv3DeBpANpoEdzscBYucUEbdLhZzUsQkPp1mjX1p+m
    Zk60Vdszz07AOcs0DUWngjZCE+lNvrU80Ch4RsFsgNzJ65xfROjCxcv/RFoYMKicTMgTQzt96sZLUxZKAoSCnzF/JGzq/2dOWwQWEBgXqafBAwyXGE7CihtE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=GeqbvrhsAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=8WRiCzwA-_JeZUz1kHIA:9 a=QEXdDO2ut3YA:10 a=94vQ5kHzWgcA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=8P97GEwaA02HRAfn5vDN:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757051AbeDFNsc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:48:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756953AbeDFNpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Frysinger <vapier@chromium.org>
Subject: [PATCH 4.16 29/31] vt: change SGR 21 to follow the standards
Date: Fri,  6 Apr 2018 15:24:54 +0200
Message-Id: <20180406084344.875956464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Frysinger <vapier@chromium.org>

commit 65d9982d7e523a1a8e7c9af012da0d166f72fc56 upstream.

ECMA-48 [1] (aka ISO 6429) has defined SGR 21 as "doubly underlined"
since at least March 1984.  The Linux kernel has treated it as SGR 22
"normal intensity" since it was added in Linux-0.96b in June 1992.
Before that, it was simply ignored.  Other terminal emulators have
either ignored it, or treat it as double underline now.  xterm for
example added support in its 304 release (May 2014) [2] where it was
previously ignoring it.

Changing this behavior shouldn't be an issue:
- It isn't a named capability in ncurses's terminfo database, so no
  script is using libtinfo/libcurses to look this up, or using tput
  to query & output the right sequence.
- Any script assuming SGR 21 will reset intensity in all terminals
  already do not work correctly on non-Linux VTs (including running
  under screen/tmux/etc...).
- If someone has written a script that only runs in the Linux VT, and
  they're using SGR 21 (instead of SGR 22), the output should still
  be readable.

imo it's important to change this as the Linux VT's non-conformance
is sometimes used as an argument for other terminal emulators to not
implement SGR 21 at all, or do so incorrectly.

[1]: https://www.ecma-international.org/publications/standards/Ecma-048.htm
[2]: https://github.com/ThomasDickey/xterm-snapshots/commit/2fd29cb98d214cb536bcafbee00bc73b3f1eeb9d

Signed-off-by: Mike Frysinger <vapier@chromium.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1354,6 +1354,11 @@ static void csi_m(struct vc_data *vc)
 		case 3:
 			vc->vc_italic = 1;
 			break;
+		case 21:
+			/*
+			 * No console drivers support double underline, so
+			 * convert it to a single underline.
+			 */
 		case 4:
 			vc->vc_underline = 1;
 			break;
@@ -1389,7 +1394,6 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_disp_ctrl = 1;
 			vc->vc_toggle_meta = 1;
 			break;
-		case 21:
 		case 22:
 			vc->vc_intensity = 1;
 			break;
