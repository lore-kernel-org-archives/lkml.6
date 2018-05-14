Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281479-2-12274255292849405688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281479; b=B/b5law8Ey7IUV/gSnLxJsDQ+h8l25QKDr6OIQPrN0X9hmYyq+
    x1XQz4xKeHaRaMMbwtGnUgupxgHnVIbBIR0swrIR9JXq5nKPwoLLmo20JUtD541P
    RP7U/Ki+6G+FuxLZpaPC7UDciTm4I17G0JNBDx/nvWOQD88KaAW3Nwz6kplC5Wqg
    w3SQNzj7cPnfb5DNnCNY6jWQ83GIQC6knmnXz2qU/2mFlX1KHu/7yvsNceL8jEg1
    FeDXi3Xfn+n8HLRr099WKVe5j+SGVXKsENeDUOh45h29ffLLcyKBc9zR6jMGt6LF
    Ga/OLq/+BZVZC7IKBJvvlHtz7M10MYgf+F9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281479; bh=ZiHk/dPsCtRP8PN4OVoSgWRodr2aAO
    BuSVsG09eDcog=; b=jETUWoQWxsV19XY3CKu9hFsx0+gtyYOgxo+mE+Dzjo2OT/
    lGS7Mq3c4xSReUUjRo6GrSHLxumhhEkZ+roWSTao9vMa5rMCRyd4KqEqUurGnQBW
    Myp9JQeUQ2pCdpYoXU8sQ3Y8/xb0CxXahtV70etUR42awcGEfftrQ493AL2Gngod
    Uuta9AOCkkF+m+6OBQABflhUoh3TcKmvLfI1tzEWFVnBw+KTtoHMHRuCfF8oodn/
    juuIC5Pcw9vqnLKCE7jHsHIDbewBlhv0pFhDxTHS8YU46av6KLNV8Q208rmhbqlk
    Hc3WUTFe2Dxaz98JLkR+5eABg0uuFLIhV4uQbUKg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=UFAAa/ir x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=UFAAa/ir x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLkGaxkhV8+sWDQTQe3I0Io1CcoT5wGSMPkCdb4bFRL3IBKdNR5DorNZIKKwbod5sT41TipZKYe5uOHcg9yFCiKC+8SmjIpwQx1I36PavdNbGR5DUacC
    kdw/oyMm9DUp67eQ/p28WI6Sb2twZryHgSQV2Emvzam20MWXGixJE7igBBKokSorhMtN9S/v1+bc08lADASgC3VdIE534S2NIvztgUTmEaMtS/XMfCKoQ+AQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Dei6p5SHAAAA:8 a=ag1SF4gXAAAA:8
    a=nDfK9SQI0lTZ1QdCixkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeENHEL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932119AbeENHAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Garrett LeSage <glesage@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.16 57/72] Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table
Date: Mon, 14 May 2018 08:49:14 +0200
Message-Id: <20180514064826.982501625@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 596b07a9a22656493726edf1739569102bd3e136 upstream.

The Dell XPS 13 9360 uses a QCA Rome chip which needs to be reset
(and have its firmware reloaded) for bluetooth to work after
suspend/resume.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Cc: stable@vger.kernel.org
Cc: Garrett LeSage <glesage@redhat.com>
Reported-and-tested-by: Garrett LeSage <glesage@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -392,6 +392,13 @@ static const struct dmi_system_id btusb_
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 3060"),
 		},
 	},
+	{
+		/* Dell XPS 9360 (QCA ROME device 0cf3:e300) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
+		},
+	},
 	{}
 };
 
