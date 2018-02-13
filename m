Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965862AbeBMUyx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:54:53 -0500
Received: from mout.web.de ([212.227.15.3]:35833 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965676AbeBMUyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:54:51 -0500
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] dmaengine: at_xdmac: Delete an error message for a failed
 memory allocation in at_xdmac_probe()
Message-ID: <980fa869-f75b-3436-a329-09613e2ab915@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mO7cimvdEupuBN1Wn+0DYEmLu0J9YFmCEsflo0bgdOsFeOVwJtv
 fu8c+OR/J/baa7E7PC17n9lIWal99KGn2nbN7mts8yB5ZcvfZWb6oP7mn1vTCsG6Qh3yzH0
 DNqWxYAW8BFPLK1oFJcuIGXYa0SDypPDahbk1heoUZTsIVdR81YnwdkmfPbQ7Fw6Z4NHIDw
 iS36qtf/89gWtxvKQhJdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QAcdRvbMPqs=:Y5uLgBfx5dIHw+xhzSsk7k
 o4OOc1lax0QrSskO6Gs9vqa3hquiFfdEDdujhMKnMd4bHlZhYlYGT3xTmNxE+0ls7Wcx5HTLp
 dlT3QKQCetyQZDZEUz+Ah5U9KxQ28SIgMd3Dme6ohLLEoMSKEbpA3Y+WuZLtMbgshLkJ2wNdi
 mdxcwGLdFlMgz0/TVwBt9wmOLGvecEWemuxv/Wh0wuXGwquhR+DV1s/AOmVDYl3189kWKQ+GO
 N795BtXnzz2AuGQ2UoCFAuF/J3ugdjAvD/YHn7pP9dMXoYPcYnucRkSWta1kc72gkgiaFNGAq
 q3eu3lDqzXkCu6Wl/wj1xV8q5xH8Mj87ati2ufn8uWggHt/OdXj2eZwTmLfDdgrxRMM2Drcax
 ynDgOhdjp+tPX5tQMERYCr74FyNxWq0HU/LOBW+fXJqUnjkn/0kwYi3F/IiB1FD4NvHODKmup
 FozG5Pb1Jwi1y5K6zANfjLAGUK3GbMde2pXeY2+u/5nDMbq+aVG1Ry7ru+65eoeJxmRoMhhRF
 OAVdf2IecIakay8zDMPhtFHovzEFGBT5sNlyH0UxPCCbEEu1IcR5THjcNfMxnPQtJxp1V3Td0
 bIA+6YnqcWmQivTKSOfvThvZROTr2lwu+KXC3THZg+ByokQ1vAJjKfjBlQYWYTExN7p2m+TYS
 0EM/GwFld3jjLT6LVceDZyRI90ylElU5oGRgTfRfbNOZ/2AdH7JqYTvPJ4xak0RvY1r7GpUd0
 VJeCBb5BvZTP1bpMxUMChJzo9hYhoKdlRxtgY4AmIFRbNwWO/VZwycy2NHi+h1amK2swlVNtB
 WTdTQigiGvkZ/BX+k9X4FtMHQVCjIhk8mirJWHEPHO4V44igHg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:48:26 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/at_xdmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c00e3923d7d8..818ab96f9601 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1950,10 +1950,8 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	size = sizeof(*atxdmac);
 	size += nr_channels * sizeof(struct at_xdmac_chan);
 	atxdmac = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
-	if (!atxdmac) {
-		dev_err(&pdev->dev, "can't allocate at_xdmac structure\n");
+	if (!atxdmac)
 		return -ENOMEM;
-	}
 
 	atxdmac->regs = base;
 	atxdmac->irq = irq;
-- 
2.16.1
