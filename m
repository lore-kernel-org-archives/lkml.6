Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeFDHZ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752980AbeFDHBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Benson Leung <bleung@chromium.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 29/52] platform/chrome: cros_ec_lpc: remove redundant pointer request
Date: Mon,  4 Jun 2018 08:58:24 +0200
Message-Id: <20180604065607.733383709@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -54,7 +54,6 @@ static int ec_response_timed_out(void)
 static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 				struct cros_ec_command *msg)
 {
-	struct ec_host_request *request;
 	struct ec_host_response response;
 	u8 sum;
 	int ret = 0;
@@ -65,8 +64,6 @@ static int cros_ec_pkt_xfer_lpc(struct c
 	/* Write buffer */
 	cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
 
-	request = (struct ec_host_request *)ec->dout;
-
 	/* Here we go */
 	sum = EC_COMMAND_PROTOCOL_3;
 	cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
