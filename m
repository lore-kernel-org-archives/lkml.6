Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Wi1SlKWKVq3NbB5IDkyu5zQoy++Jm/BgDWGJiq3cj864tem6BoB2+/Jd4pb121DZU17Wi
ARC-Seal: i=1; a=rsa-sha256; t=1518708556; cv=none;
        d=google.com; s=arc-20160816;
        b=WRqDBjsh2PSi0R4UQHjO0PAyazNnHbjdAHIEXvZl7Rg63+a1IsRVQf8nX03nhy6t/a
         I07VFu3hREGic27JMugvlpRHh9wbyMmwn7udDgCWgtTUnpHeVZ2XLF6iTgFgUSa90Nlu
         m1Nq0lBapd2DTlXnLP7ZhEcSUDaOfs/UDZB9ukp570bR4COy9OZc1G+Y9bAupg8mfacZ
         lLVZOqQBZDoAy4Sn+rsnyGNLLlNtkI38QyCp3PTI1zPqtj06iG9exOmTvCGFEDyHZUkx
         4kFVCIooumwlcuLEEreychKKucCQBB97m5wEr1PxRC7ITqoBur3w4UaaAPU6u+ZhvQY8
         SX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0jQ8JQVBZUHvlt5Ot6I8KbHhGq60uLoH3L66zDgwjeY=;
        b=HH6aJCBS7rzM6yxXYRYVGitOH2KqubOE0MSNng37FtUDeVubgMoX39YPtK7lIs8Z4e
         clpg9YrEcuYuo51eJ8dVJeGqCXRDH+Y4OmJ78qc+ZY0nss+zW33x+7iawSGbRp9js3/1
         U2FSeOfuqWaIGf6I8K6EaYrfK1/RNENWi9fu9PxW13eI7Ac244KveEkqV8QBLwuBIX6/
         ZY0s3Y8R1CIvRZUlhoqGUOZ0SkIBjlwlmtxxAK437QBlZzj7E18jMCKbSctB4b3PI8tW
         8UnfpIhINAZHvp4MDsXhE721G+nxy6u726OK84QhI2k2504Cj5XNbfm/hiyFO8bUdr6P
         Pkgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wang Qize <wang_qize@venustech.com.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 84/88] ACPI: sbshc: remove raw pointer from printk() message
Date: Thu, 15 Feb 2018 16:17:51 +0100
Message-Id: <20180215151234.118597794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480780987314959?=
X-GMAIL-MSGID: =?utf-8?q?1592481342710229325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 43cdd1b716b26f6af16da4e145b6578f98798bf6 upstream.

There's no need to be printing a raw kernel pointer to the kernel log at
every boot.  So just remove it, and change the whole message to use the
correct dev_info() call at the same time.

Reported-by: Wang Qize <wang_qize@venustech.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sbshc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -275,8 +275,8 @@ static int acpi_smbus_hc_add(struct acpi
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
