Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805134-2-10067220757179728181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805133; b=d8616Kr/hnpSpcWIl9ip93YMv0Hq+EC1ao+v+oiQZ1QjnNI
    uavy6hzROPh50j8RC4hFjl1E/q4k9BT+bP3ix1EWSoYeHxfTHbkQAGn4hSvqlnug
    R4f7IoktUa43lZMV5f8zLBj8LsBxofmn2KZC/vJsWIkPsFC1P1NYG+JbGFq/oCvK
    xSIgAhGkE+VNl8Yz30NHvMP2hGu1TzIJNERqHKMEReWztPjO8YesFL0WBDv4Ft6p
    QnCz0oTxqnmkcmw8xiuETIqoEAegZshzAVmuyv4Fchay9K4VqsCpGTvJQT4C5c8X
    ApX8l2sJSycrmXTPR2Q1EGoXnr8s7OEdG9i4uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805133; bh=ilc6dHdC0zmZ1Qfujw99Crkz6r
    3k5s3/99nJbgM/hZg=; b=pGTT7OPN58XpS6K/wVB1fE4Dk8eKtP5vOJmbTjbi1g
    V0If+qW77i2xogMcFVVEfpiTUUVFu5P9K9WXn7MLGbAPIXgFMkoRYOM0ceijA25t
    KztLE6V+ZDNpSFZCid5pqwPqBkdTb7uYk3jUYhyxeiAf70EKEO/6ehZ82gw9swx4
    Vlb0RPOVt7Jce8Rmm9PdwPe/mmmk1Plmfgn5mRSPUfYG0jUEZVPrQCHBfAHRgkw0
    NTSHTL5O7CnuH7epZEPgBk2FoocnnR6IQqal8nYUur260rumd6v0IkxERaNLXF/k
    70IAe7Gw/IOjUM1VT/qb8BmXX3fE1XKhcv+OE6TL0g/A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbeCWKEm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeCWKEk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Michael Brunner <Michael.Brunner@kontron.com>,
        Viktor Krasnov <vkrasnov@dev.rtsoft.ru>,
        Jean Delvare <jdelvare@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 020/177] i2c: i2c-scmi: add a MS HID
Date: Fri, 23 Mar 2018 10:52:28 +0100
Message-Id: <20180323094206.080544433@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>


[ Upstream commit e058e7a4bc89104540a8a303682248614b5df6f1 ]

Description of the problem:
 - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
 - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
   Interface Specification, version 1.0": "Each device must specify
   'SMBUS01' as its _HID and use a unique _UID value";
 - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
   and implement "SMB0001" HID instead of "SMBUS01";
 - I speculate that they do this because only "SMB0001" is hard coded in
   Windows SMBus driver produced by Microsoft.

This leads to following situation:
 - SMBus works out of box in Windows but not in Linux;
 - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
   SMBus work in Linux. Moreover the same board vendors complain that
   tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
   and produce errors.  So they need to constantly patch the compiler for
   each new version of BIOS.

As it is very unlikely that BIOS vendors implement a correct HID in
future, I would propose to consider whether it is possible to work around
the problem by adding MS HID to the Linux i2c-scmi driver.

v2: move the definition of the new HID to the driver itself.

Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-scmi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -18,6 +18,9 @@
 #define ACPI_SMBUS_HC_CLASS		"smbus"
 #define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
 
+/* SMBUS HID definition as supported by Microsoft Windows */
+#define ACPI_SMBUS_MS_HID		"SMB0001"
+
 ACPI_MODULE_NAME("smbus_cmi");
 
 struct smbus_methods_t {
@@ -51,6 +54,7 @@ static const struct smbus_methods_t ibm_
 static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
 	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
 	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
+	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
