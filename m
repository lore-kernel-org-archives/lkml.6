Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELu4bnCKqSN5K62W5pnjeQ/NUPkjt0fv4tSil9OeeTERLrnzCtZiGnm6tuCVpF0iIo4viXDB
ARC-Seal: i=1; a=rsa-sha256; t=1519831333; cv=none;
        d=google.com; s=arc-20160816;
        b=r3ew0N43C8qDVLjUEo3rgN9Bi/CipyOUnv67v1DA/p5h5IxY0IdC9YbFHANtCV0vBp
         Q+Snatuhpa6doVuXucEsViQxNo+2rYLOCirb5vEk7HJuYhuF1Qj5M3sbQzcDMH1sbJ28
         8aIX3oS+OXc9J53v0BCzTkbkv917dIveHT2IxL2Vbcm7/d6Q3OP/FlMQVcdpZ/jple/I
         +6l3eITQZVozCL7wzEUxwsGqUykc6SEpZWTZc4JZrJmvjHfZDDbdG3pvEb+Wmd0Z5opu
         TNYm9p//IDtbfLFleVa3lLubqMwPvvsrDCbfolcM7K6iqs++SpqhyxI6IW9KVlai+yQA
         0glA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=8nhOJRiM7RqDQpQ8Go7VX8T1OweYQe9I+y7WaX/QJqA=;
        b=bgg+AxpnBTKw2HgzBr5n7wC7u6ct4WD3YEH8NjyjJU03yFk/dpQRioIWfiSi87hd9Y
         DUIBC01Nuq5Kdm3NHthhnXTntbT6q068RalCAuiDHXXhJanS1OcFqe++yuM82mf/kaVV
         mr3Phtj3FiD5giXzup82VJDmbqIjPO0g6E67jcQ1R/NpkLafBruzoyKtHRGdoeJ+nBvb
         aWuWT8virQ/XU/MBo46PotctZiL2v31RfkvyASdR89BttU60FvaMkR61t8gAagMXPafb
         adIQyEFqvpib3WPEVUMt1vDMV037kJKVr38QaFV1NLVYa8owMPwDeKdRGVx9HA0PqTEx
         O1xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Wang Qize" <wang_qize@venustech.com.cn>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.921142917@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 139/140] ACPI: sbshc: remove raw pointer from printk()
 message
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658659996295127?=
X-GMAIL-MSGID: =?utf-8?q?1593658659996295127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 43cdd1b716b26f6af16da4e145b6578f98798bf6 upstream.

There's no need to be printing a raw kernel pointer to the kernel log at
every boot.  So just remove it, and change the whole message to use the
correct dev_info() call at the same time.

Reported-by: Wang Qize <wang_qize@venustech.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/sbshc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -288,8 +288,8 @@ static int acpi_smbus_hc_add(struct acpi
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
