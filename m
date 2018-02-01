Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeBAUt4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:49:56 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeBAUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:49:48 -0500
Date: Thu, 1 Feb 2018 21:49:24 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: srf08: fix link error "devm_iio_triggered_buffer_setup"
 undefined
Message-ID: <20180201204924.GA26839@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:893swCEBrlZ3YXgp3oL6qErIuHEWl0Scq9445wCKuk9qf85Hcje
 fOkEbCzLQRKZFEn/27CtZRWNFEgnLVK/z5bJFGVBAyu8iUyPOz7/1n4pLhDCa3yv/LxNA+1
 r5562xMuRM6iO4lt+suO9KjZDXI9sOQ9pREbP7WWNJ50MsXF6lPI8owJB5u+JYbZH9FxiQI
 iUKsNEGauvovZ8Hoab4KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/FiX/Z0x80Q=:Y8IzyWguO5Po/+QSsiuVQj
 AzR3oxKOIfOUHdlyfo0OFeU+2+l90sEy+Rl8yO+QEjTgvrNOHXKp5GQPIAnyh6VBi6BQlNJWk
 KM9DXN6ZHnMsWcYEYDnyyKZoYamQ5LD/lHrdBKhKtpRTCmSzgyh14PfeX9ZLRE4S8e01darsQ
 PkmeFEhkPxcOOISo9W/wRmf5hQKqqcGmJGhmiQUZURIIgPVY7u5JBH95vhWNwGJ7cEKi7BGjB
 pYATcuEjGGX1fwMvI5xElM5xABJ3Fryg0CcWjnTheP2IjqF+JC2t2V1/MG3lSOOi5cE6WXCQB
 pwKFWFZYkuCe9r8p8fA2vNDjaJoHwOidqZwTdFDAnnQNmXSRSISynB7b4NpdxMPlmkZv8BeIi
 Lm7QPpabLCGDikzNOTeA+fmUTEtkJhPCE83rXjLm7vvV01bThB+JBrjEosBmZtr9w/PU+DS9r
 ZTPjIInNFGlED3wBuYIfYdGxk55eRbsQw91TCRswSl2EPRZSuQm8wcAB5fHKyCqq3Tq5TQ+Ih
 6D38RxNZfpKT5y/k3Gv9K5MPpvzLmWHF7ihhv5XtbMv8XJa1jzpI86kYtorZugc/nrUnkOYjU
 iUOjUQ1J+MRwGSnvL79+zO1LSUVvtNrTYIOhykSlHOiWhM4cUTBWg7rHAHwDI71EKC7U83PiW
 Xe4HKB4Fo1taDOJHCexKCY85aRpnBju0Kv+c1mBbiV2TOJlMf3KudQfkm6pa/VPwX4mfJ+ANL
 q4wbLDGHnufHfaXaoo6ZYkvLZ8GJ6FhpW/cZZg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions for triggered buffer support are needed by this module.
If they are not defined accidentally by another driver, there's an error
thrown out while linking.

Add a select of IIO_BUFFER and IIO_TRIGGERED_BUFFER in the Kconfig file.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index fcb1c4ba5e41..f726f9427602 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -68,6 +68,8 @@ config SX9500
 
 config SRF08
 	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
-- 
2.1.4


-- 
