Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227LwNMIpjZrZnFWNr6ZJmCzfmAHc4F0RbsMM50jMkjc8AbMxwPaS8FuMGR14wfueZkjLrTr
ARC-Seal: i=1; a=rsa-sha256; t=1518708019; cv=none;
        d=google.com; s=arc-20160816;
        b=VA2wiqytDZKbaB8LQuCgxtPkRmbWWqxMLd9TuIugrQyiW52MaNd7xuxBN4gL3tWtUi
         w6v9OmBJOXwQRYVxsEyal6ASBqDtkpF9KzE425Z8qf46r89r8OqKUQZY0gNsTjIy3e2C
         hknEbfJeS0LhzmuTfU+vzhEJTNEFOuWfENuf47pLrIMD+5xpT51ETpvjK3P4qGQbJI/w
         k3mHSn2vljhUUxdpae9aKKk2xNNg6R224MM+ZPZZykKIbCJOuruNdJ26yLsxlg30OPy2
         CdjnTZcKSpbAuh5PalOgrddzHez0LqC6FyXqbAsLfAv3O9qOLffnfRm2HYmqh9HBG+Ux
         H/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZxvOgjOKqTrGSo8gp+/EUvoABDk/EAD37qOaXd4lS8U=;
        b=wwPTLguBfYm7TGX+CdTCKRHd4BzySHkFFqp1wjUNvMQSnSrR6V5gyWx3cU8sGmUcUc
         I8T1DGJYNFwcNJ8C9avK4jy97+SY+9jhSxcCSeghbpB6iuEp9x3MTiltjQjawGrzEjpi
         Z3Ky/fnnSnOAn80jwp4zyvGTuoDwfAmplBAWgBkw9JylYM7GJQGYTsy1XmfXlM1hJ+aZ
         EDFn7YXrsHMwHCdqxUtQKBQSb9IA3bh3sVzcrBASm0Bv6/yC8vhs2jSHFWUPG63oBlIm
         /Vo0gGQhfwGgNXJiMUYdFgm0gG11t/4lDUQGOHy1OURejfFQLn/ka8OgYX0Pc6dB7hoL
         Z1yA==
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
Subject: [PATCH 3.18 44/45] ACPI: sbshc: remove raw pointer from printk() message
Date: Thu, 15 Feb 2018 16:17:35 +0100
Message-Id: <20180215144125.285145027@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480780987314959?=
X-GMAIL-MSGID: =?utf-8?q?1592480780987314959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -309,8 +309,8 @@ static int acpi_smbus_hc_add(struct acpi
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
