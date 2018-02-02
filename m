Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590997-2-13298878348038848420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590997; b=VuAc0YFCGIvz8dVXA+FWLHr9M375wpu7yJ61M3wRcBAxBUM
    sgvlbkUV8yEemRZPdH7Ivz6qeRH5Wj8w9az6ZI6DXLE9mhcBZCEtTEg0IPj4YtC6
    3f7fMN6b1FNnkTx6z456hpP5pYYzVVg3TtqoyyfVGchqfrBuCuuifxrz5mFB4fGP
    qPlTPcNPirROz0qRPke7WItyxdIIiuGbu+4lk47p9b5dELxOYZslQVbeUpmsjd0a
    FAc+4uaO3CIxsS/2L7hHczQMYU8nfr8bPzR0LycaF7xIQRCWzlBKmeBoOmAVmGs+
    agRwu9FJzaQw+PZgquma/ovs8HxyWIxzTVH+2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590997; bh=bOU+5ugoaAaD/A7llAkxkttDoR
    CLkB1ABhF11uvLhH4=; b=OMfGSTlsqLtYPQOSMbTLAawn0vLm35PqXRcwG6h3qG
    lf4hXPJvgpzHGy01cfpyB/1rRzCnYzSfjn06IQrmdMjFN9mro/ubVHAKHpI69uOU
    4OtM93QGrlhCg2gNF7FtobBctEUjaS3cJ01rtVsytyL+zXcfJAgVPklZS8iwmGzO
    ACYnSAnT6rE47bNyzyqMs2ynddQwG6xwUeF2aeq72nvZ4ZnjyDjICvgKfHAKGrm/
    dS/GTWJHzZ3IqmlpjtVUOOLDl0B/r435TYjPIlenGHc9G+Hr6nKQrzdTkmDrexWj
    Q5rksDoYbc9mYTerQVYylnSOEFGv3MVBFMCR/wF03J+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeBBRDF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:03:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeBBRC4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:02:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Doug Ledford <dledford@redhat.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>
Subject: [PATCH 4.9 02/86] net/mlx5: Define interface bits for fencing UMR wqe
Date: Fri,  2 Feb 2018 17:57:22 +0100
Message-Id: <20180202140822.876617777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Gurtovoy <maxg@mellanox.com>

commit 1410a90ae449061b7e1ae19d275148f36948801b upstream.

HW can implement UMR wqe re-transmission in various ways.
Thus, add HCA cap to distinguish the needed fence for UMR to make
sure that the wqe wouldn't fail on mkey checks.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Acked-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Cc: Marta Rybczynska <mrybczyn@kalray.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mlx5/mlx5_ifc.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -737,6 +737,12 @@ enum {
 	MLX5_CAP_PORT_TYPE_ETH = 0x1,
 };
 
+enum {
+	MLX5_CAP_UMR_FENCE_STRONG	= 0x0,
+	MLX5_CAP_UMR_FENCE_SMALL	= 0x1,
+	MLX5_CAP_UMR_FENCE_NONE		= 0x2,
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x80];
 
@@ -838,7 +844,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         striding_rq[0x1];
 	u8         reserved_at_201[0x2];
 	u8         ipoib_basic_offloads[0x1];
-	u8         reserved_at_205[0xa];
+	u8         reserved_at_205[0x5];
+	u8         umr_fence[0x2];
+	u8         reserved_at_20c[0x3];
 	u8         drain_sigerr[0x1];
 	u8         cmdif_checksum[0x2];
 	u8         sigerr_cqe[0x1];
