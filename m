Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802257-2-15919284808325271868
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
    t=1521802256; b=GYCuksH3UahDX3nCL3mkBr+fzblHVj+U6bOt3lWmY/dOjCi
    IZuqbq9rj3n9Xqwu8ctKLcpdJMMeL3HyqYqQX8a+pFxZIbPSrtLfcquUZgf+Qj5W
    A7DiTxEQvg1E7drIseeAWlp3EjEWSdcREvlAjLsmHqlY3nJlLEwjMbC7wWYdydKA
    YvrvtBhw4znAQ71CwxdqEhPyRE/GH8WnnzRnmz7l+JJCtV92QnKsvmBqKGR5eKod
    ExjjZV/X5Z6894/K4qmeqLwqP7UEhLo6d6fqpRkBXjIIu/1IXJsy202zIa4L+2Uf
    50Xlydpalzdyrz64e1MHdzHluR6u0n7tOXMQyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802256; bh=PPWXRL91QQItJNGmVDOyn+TL+3
    b3USnW5xToDo/EVC4=; b=Con2lEx+4glEfh9TiEQ8lYskDPPDsGe1xCw4/YlBMF
    i9wgrvXX6IKBlI5f5UtwHOt/CoS5A3o9HKZV1aMXM6c6FBtOE7C41zyDmdXMTgXo
    IgCEYZUbo3k3xCr9oEoVg9t4Dom7wYTx6jD5yPu+ftEsj5aeHlBlnZHokfDhVIa2
    9DIDFBijmUVkbzE537kkrAn2pFtQd+vlAZ2m9imwMLqZsmL7l2HpaQe2GpnMqACe
    WUYDDr9xWcbZJPuKg+NpWZI1U+jLLK9hvwYS6sQccMra3Q+YjxWisf3MYLB9LFqP
    Nuj4amq1lJku+Bl/pWm5wWl6g4sp9Sv4MWlRg5ilYsNw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCWKuo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:50:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755766AbeCWKOe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:34 -0400
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
Subject: [PATCH 4.4 16/97] i2c: i2c-scmi: add a MS HID
Date: Fri, 23 Mar 2018 10:54:03 +0100
Message-Id: <20180323094158.399312214@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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
