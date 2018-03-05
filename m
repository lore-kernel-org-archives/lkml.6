Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227129-2-7746058169347394611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227128; b=jarrbqik2EVmSgI80wAgxeaMaF4VnFRO7WA996M6S//70po
    3OYk9tXRTjilyl7EpB/Lm7IDfZnaT0dmyPEr1PPNNP17P9n8UZodqJ+Xy8o75OPz
    kJQBri5o8cQ+ITq5Uq4y/lZ1FRG4SRz+m9WCry36TGd50fIB7KxKe4TxJ1HiJqCe
    KJzQy3c8L652vZH7LkQ0IV+W/AcO1a/43aVbH5SZBd65Kc6bVaCJkMAA7w9H6Oy6
    Wk+r91PfJ6DgjS4O/dDXWBEqNwDOJwsjMuT4RbMyW8sZaQoe1u1/krrAtiKzUna0
    cqsPjVOBkyN3TtXi/tehHct/hDxp5VQwMFpBRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227128; bh=kqi3QDiMZ2nQXCMkmk9jgkmzHulZHc7KewHqgny7RB4=; b=R
    ek1dhfZolJcT9fw0MSen1L/mot1NOAolSxB9u+qWez1KkRLUkQyyli2CJCuZog+j
    8KnVw1UO3XVbqujG7WUMIXzGrUrYnTzKweX/cEyYOOP+Hy84M99/NQ3r+zVN96gc
    JlfLSVFePvyMD5iWP1lhFNRzhG/CzEdoWYUZO3oNWh1lE1ZquaeUWqPsPzS/Lzic
    V577HhUIkEvkobs6Nq6x8fRJsQ8aowO6LSZkf3inHhdPDmR8EMsrqjoO8QXI4UoE
    1DqKsUnMcZHaG3xOk3aNZ/X2pp1T/2E4jF4wD++t42XGoiZyCXxI8M8hskaUjWcB
    04bFpo6KqmIEuumWXm1OQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 07/12] hv_vmbus: Correct the stale comments regarding cpu
 affinity
Date: Sun,  4 Mar 2018 22:17:17 -0700
Message-Id: <20180305051722.19157-7-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfOOgjQbpPLEUACaNnRs532IZZhW10v2/CAvkpP8QMK38D5DC67IgtyT/OHtKlK+5mjKbPeFz3UPXZqLwpfv11xvUugHnytD+cR0gP9X27wKzA7mhHGrQ
 m6ZNpALEhnzk8IWiK6gUhQ85SB4/jTxJfXfTqqRqeVw9Mf0F2JjLGaW6VAMaCR/ywGiCCQ0zlA/O93/8F81fZkO0ARFI69kLXLQHl2qA8kJGdgTSk1UEyW8C
 A/9Q0DpIjXYFzX/nirnXAp6CMgQM2kW0q4HxfElxdtLEMxxZdjgyvVSQFwjnlH06q4DfM5e1H/t6QJFQkzk1T7zJGqf5F5wh1e0+iVdcVE4QRCoDILgHAHP6
 p+Y7PsYIAY4Y6CKDz+v6Ohb+PHL8jY9540meIaIAIM8BlLscWSJE+VbT1wFjdhT4Wh7Uw8JUiPfuKQkpEgVHo2NZJ02yiDNoRLrpqUFeQh1ERqJE+GCUo+5x
 vD/LeMDrUcozyoklBbdbmIVYVJNx6eLHND8ta7rfRL7ENW0dbzTAExs39pcMbOIKgK+o+rDWkzUfUFp/OplFUvg8gEUkYzCXH8c1uzWOKaldyfQ32miB5j8x
 6It2M+15dWN7BjSnGv03PBGe
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

The comments doesn't match what the current code does, also have a
typo. This patch corrects them.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 6 ++----
 include/linux/hyperv.h    | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c21020b69114..c6d9d19bc04e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -596,10 +596,8 @@ static int next_numa_node_id;
 /*
  * Starting with Win8, we can statically distribute the incoming
  * channel interrupt load by binding a channel to VCPU.
- * We do this in a hierarchical fashion:
- * First distribute the primary channels across available NUMA nodes
- * and then distribute the subchannels amongst the CPUs in the NUMA
- * node assigned to the primary channel.
+ * We distribute the interrupt loads to one or more NUMA nodes based on
+ * the channel's affinity_policy.
  *
  * For pre-win8 hosts or non-performance critical channels we assign the
  * first CPU in the first NUMA node.
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 93bd6fcd6e62..2048f3c3b68a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -844,7 +844,7 @@ struct vmbus_channel {
 
 	/*
 	 * NUMA distribution policy:
-	 * We support teo policies:
+	 * We support two policies:
 	 * 1) Balanced: Here all performance critical channels are
 	 *    distributed evenly amongst all the NUMA nodes.
 	 *    This policy will be the default policy.
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
