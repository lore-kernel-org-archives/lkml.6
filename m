Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeE3LeE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:34:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60834 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752448AbeE3LHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:02 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Julia Lawall" <Julia.Lawall@lip6.fr>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.848404530@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 120/153] USB: usbmon: remove assignment from IS_ERR
 argument
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 46c236dc7d1212d7417e6fb0317f91c44c719322 upstream.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S1,S2;
@@

+e1 = e2;
if (IS_ERR(
    e1
-   = e2
   )) S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/mon/mon_text.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -386,7 +386,8 @@ static ssize_t mon_text_read_t(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
@@ -413,7 +414,8 @@ static ssize_t mon_text_read_u(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
