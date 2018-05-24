Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155558-2-4101122324612370457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155557; b=X3/rM+0N7TXfuFCXp8+w2TemlBqoAfHaia3TisSR8RXNBaueHv
    RWKGjZRjpbp9yNyqjPdL0G2cFHPPWqtCaZ8G0IBXepMsvvcOJKtw6S7g7MkyxZE1
    X7IzHFOkjF7itCYR1bIDJUQ+CDgMO2eHDb1k6gRs2pRvXoiCt9C7+HhP5AJF4O4Q
    gp7zThRXOBw3BzTB8ZlNnQkPcYIkhQp99Bp6BVSIxdejhv/AcmDhNtKKMqgn1WrC
    A0KNGtBGrFdR+dmQcQR+Njvdt70qZ9uWVrgEUHqUh7hvzSO3mfI417p34IShwYDq
    7pCuGF8TjCewqJ/Wqjvewh8zqWZfaN136sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155557; bh=7bWO6OuMXJR469gbiHcXKo+ZHZdkUN
    49CINKEV8cbt4=; b=SoHrtjxtxRxTasAvC0mG1owmFtvrjTwGIQ46ISYHdh15Ss
    yBamG1AmDpj2yYkEhuPyHYF64QIDpYdhdIjVUrRJ/72UqdRreYx+e++MfuINN5kW
    QE1J6pBI7Zy1/KjgtfyuFTk3dPf+ZawfC23gAswbhnDmMbOs58jqFOI+m7DobCKK
    fyIRmDMgTa9pn+OFHOWrrYCvgcDbG2TbjYJtc3EkhtJ31EYSYLfYqvTn9CvYCNHO
    CCa45qDgYTd26LBf1MVCeZVmmpkH6vvcizC09k8uhI5Q6PtJhZ1pnt8KlohQ7vvw
    KyFdsS8RUMwE493LMScvJtdzGzOPW9NvRKzBjYKw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tI79wDVZ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tI79wDVZ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEBBT+HF5feq4uSLqSdfTU3SYD3LhpAcNBIAwFwn6jIoZ3a/rOxiM3bq4xBnFOJYkJp4i7nPDXqkSdCo+x54/+OyY1rrtrU+5NKDDFJFPpRtnFkcygMg
    DpC3G7ED/6WlGmxPC+3LHqMizS40XuTkuDFyiiQ6tim249bGhqd/Ahd3Vfd5UJM7hHOhwB9up7WI1WmajE5Ox26JXQS6wkULup6HbPbChQL2mIYWvtP1heFb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=8X7r6ikDbfErnXypJ8wA:9 a=QEXdDO2ut3YA:10
    a=3Sh2lD0sZASs_lUdrUhf:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967870AbeEXJwd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967571AbeEXJw3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 029/165] hv_netvsc: change GPAD teardown order on older versions
Date: Thu, 24 May 2018 11:37:15 +0200
Message-Id: <20180524093623.155155824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit 0ef58b0a05c127762f975c3dfe8b922e4aa87a29 upstream. ]

On older versions of Windows, the host ignores messages after
vmbus channel is closed.

Workaround this by doing what Windows does and send the teardown
before close on older versions of NVSP protocol.

Reported-by: Mohammed Gamal <mgamal@redhat.com>
Fixes: 0cf737808ae7 ("hv_netvsc: netvsc_teardown_gpadl() split")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -570,10 +570,15 @@ void netvsc_device_remove(struct hv_devi
 	 */
 	netdev_dbg(ndev, "net device safe to remove\n");
 
+	/* older versions require that buffer be revoked before close */
+	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_4)
+		netvsc_teardown_gpadl(device, net_device);
+
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	netvsc_teardown_gpadl(device, net_device);
+	if (net_device->nvsp_version >= NVSP_PROTOCOL_VERSION_4)
+		netvsc_teardown_gpadl(device, net_device);
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
