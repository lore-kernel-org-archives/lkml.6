Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408516-2-17545110615190818357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408516; b=cvpxP2t/1rSLuPMYmG3pZ95TVoLr6D4N/D4MwwiQezCfRoiHby
    fUDpGzFH4DRrGIJVb9T5jG9nQv51GIGZL0ThW2V7pLJr85O/PcOj06ry1exS1tAC
    jodWHtNnNLnwIU6bdZhPdlWTpVuHTp+LIjVtJk2hJ0T97TLIdYKNlRwNnsstbSUT
    e0MnvPscHw3Z6v6N5DpHmqAo+Wbn2QhBE6hJE/3UQ/j4oQhSEwyYq99GLjrq3W/9
    KBPJFixsQp0jpcL0Diz2UlJlNwA5owAxstcPb77xrZaDi9hdDnQLTskwrswOfdyB
    Wh6iP0syKYDQOBxt1IcBFxjSWHCU9J+9G6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408516; bh=Mf10PwSaDY7K9yuZiI0/o4SFsrMLY7
    VN8Gi8sYaltOI=; b=HzdaSOlvmsRO7yfKGVM4Qj4Uh5k5UZS6bInczVFhNbHWH4
    T82/eBfpemjY+PkBh0e4hjypT0EB7OPaaO0x68uKOrXFE5Vv96EkD9UuDzByqAba
    NASJMGAAE6K+ZnlJ+jnYbhKjjgWsF67bsahjCvGFAlztlpGypmut2gU0f4O3xGgs
    pnzvkn0yqJ5wjlX+RVaL/MBngLyQABpOCbpfd01pU39edQv7+SQlW2T/RA8+6X+Y
    xOLgmyoB1MjnPT8fPiPKBj06yUSxa3HTCexi3cT/uGLuJPbYUmjZr5BGSKXUsi2d
    C6aWXS0Y6EtRWpPwiVofpIwUS7wx81XoArtB2Q4A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHZcBfRuCuq8jHOMJ/1jQfAglIM0wrbd3RWRXjQbVzrzsPM1d17fAtV1BNraUQkeSc747CXK+dTQMTtzka0YVM1MUmJidgZvoiVM3mAQWanT78PXrHhF
    G7GZx+d/kF93J5Ue2l6HUqjrlvWV2hp2JjvhiyscTXnWC1ZAQJC165OqHMDjVCOT1KaiX36is0YOwPVCbMgZ/aR7/kDk7N8R3FbeSGtmx06hYPA+8TsboaLT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=DDxhZGchlXUlpDgeMsEA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757040AbeDVOsK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:48:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeDVOP5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.4 02/97] parisc: Fix out of array access in match_pci_device()
Date: Sun, 22 Apr 2018 15:52:40 +0200
Message-Id: <20180422135304.767319689@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit 615b2665fd20c327b631ff1e79426775de748094 upstream.

As found by the ubsan checker, the value of the 'index' variable can be
out of range for the bc[] array:

UBSAN: Undefined behaviour in arch/parisc/kernel/drivers.c:655:21
index 6 is out of range for type 'char [6]'
Backtrace:
 [<104fa850>] __ubsan_handle_out_of_bounds+0x68/0x80
 [<1019d83c>] check_parent+0xc0/0x170
 [<1019d91c>] descend_children+0x30/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019cd54>] parse_tree_node+0x40/0x54
 [<1019d86c>] check_parent+0xf0/0x170
 [<1019d91c>] descend_children+0x30/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019d938>] descend_children+0x4c/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019cd54>] parse_tree_node+0x40/0x54
 [<1019cffc>] hwpath_to_device+0xa4/0xc4

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/drivers.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -648,6 +648,10 @@ static int match_pci_device(struct devic
 					(modpath->mod == PCI_FUNC(devfn)));
 	}
 
+	/* index might be out of bounds for bc[] */
+	if (index >= 6)
+		return 0;
+
 	id = PCI_SLOT(pdev->devfn) | (PCI_FUNC(pdev->devfn) << 5);
 	return (modpath->bc[index] == id);
 }
