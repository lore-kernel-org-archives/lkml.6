Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184485-2-5412701023438234743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184485; b=B18whu/E3Vt64EjJIgCC3ALNZT76tN5VvVvybxeDHfbfZEF
    DU83p4J7w1i3DgUaKSjLTAfXI1nf1ZO8bH4EtTvxjpo9Lt7Lx24K+/H/bVwE3yQr
    b7YX1EiKwhvRVr8ypmFInZsdIqguVUaRBqkYWYeLmbWZOuiKTqcveEZj5JGTfdKW
    9X+dTBR94moWt0lolT0ZT43OmojQQ+cCzbue7rXrRm4RmcJHx8uxALGRqzYvelSr
    9UK+5H6lcWrKmnu1ZgzkT9XwgZFFPYqiK46dBKgkeOGejPTrDkp0H75d5ovg/pyR
    EKPlJCkjt5tsL+1nmmgdJZuosKGyZprG8JeTx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184485; bh=nlG88uuyiEj7eyJLWJDQDZ2TCS
    s5x5Kmp9FVkIZx7nw=; b=fJGQFUAm3gU7QEVZjKKOotxpuY/Np7Lk69hjS/SnDC
    l5JkXwZ8Hf7pAkEMhBIYK8C8LaTu0z8ovlTlr0IQbhd1eDb7LmvNK9eqVVHj0rA3
    njlhJCwdl0J43/ateN7mmctj5YTLv5CzDvYKaxiXvGTos8TK+J6DhoAh5zr7BTiq
    gwZgl2kn1vYKrHfFGsOzk3IuS2HDGZcqWbHlTiIk6K6ejD5jfejTIAk2mxOhv3Kf
    Je1V0Q6scs3FKVtPgPcLhDL7Nn0zhXCaN6TBIEqELiWaMsJseGToqmGk6jabcUCJ
    275LDwpCQlhsin2MvV1jV5ZJ9HpoOcdPrpKSbqaVn3ZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeBINpk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbeBINpi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Cathy Avery <cavery@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>
Subject: [PATCH 4.14 22/22] scsi: storvsc: missing error code in storvsc_probe()
Date: Fri,  9 Feb 2018 14:40:11 +0100
Message-Id: <20180209133935.764813846@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit ca8dc694045e9aa248e9916e0f614deb0494cb3d upstream.

We should set the error code if fc_remote_port_add() fails.

Cc: <stable@vger.kernel.org> #v4.12+
Fixes: daf0cd445a21 ("scsi: storvsc: Add support for FC rport.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Cathy Avery <cavery@redhat.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Long Li <longli@microsoft.com>

---
 drivers/scsi/storvsc_drv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1826,8 +1826,10 @@ static int storvsc_probe(struct hv_devic
 		fc_host_node_name(host) = stor_device->node_name;
 		fc_host_port_name(host) = stor_device->port_name;
 		stor_device->rport = fc_remote_port_add(host, 0, &ids);
-		if (!stor_device->rport)
+		if (!stor_device->rport) {
+			ret = -ENOMEM;
 			goto err_out3;
+		}
 	}
 #endif
 	return 0;
