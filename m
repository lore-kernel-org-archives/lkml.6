Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeFEREu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753068AbeFEREs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Benson Leung <bleung@chromium.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 14/61] platform/chrome: cros_ec_lpc: remove redundant pointer request
Date: Tue,  5 Jun 2018 19:01:35 +0200
Message-Id: <20180605170118.539571494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit d3b56c566d4ba8cae688baf3cca94425d57ea783 upstream.

Pointer request is being assigned but never used, so remove it. Cleans
up the clang warning:

drivers/platform/chrome/cros_ec_lpc.c:68:2: warning: Value stored to
'request' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/chrome/cros_ec_lpc.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -49,7 +49,6 @@ static int ec_response_timed_out(void)
 static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 				struct cros_ec_command *msg)
 {
-	struct ec_host_request *request;
 	struct ec_host_response response;
 	u8 sum = 0;
 	int i;
@@ -62,8 +61,6 @@ static int cros_ec_pkt_xfer_lpc(struct c
 	for (i = 0; i < ret; i++)
 		outb(ec->dout[i], EC_LPC_ADDR_HOST_PACKET + i);
 
-	request = (struct ec_host_request *)ec->dout;
-
 	/* Here we go */
 	outb(EC_COMMAND_PROTOCOL_3, EC_LPC_ADDR_HOST_CMD);
 
