Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrmQ7oKSU7BYSwJGEaulIR13UuE2hNT6G0y5mfIeiVyDmE2knKrE3sDMvBkwDjT2ItNKFid
ARC-Seal: i=1; a=rsa-sha256; t=1525767303; cv=none;
        d=google.com; s=arc-20160816;
        b=SC57D/YJIPLUYkJR3iaCdodfTnmBu0oTDB92Q943OOqCJm9LVJelddQm5JtEYwE5fp
         vmsM3Oy4tNuAdVxS9R5Qdk1JVAxsHQ5Q4a5xO/2x5pOwT/9FpN9IGSJ3EjOySSEo5n+1
         I3pIeZINvylvJCLPtcxZcq1OZ48+hd0ZHrL3rW1arniyTcDPwnF2VHkcUcgcDbMEN4t1
         qUtUrIhktrr7kAbcD4VbrN3y5t86IxFJ8fHkwG4YfYtl58tEmzSYGFj+/mWeOqs1LTCb
         exNxXbXCBe1ljJHnveQmxZGEjaWK+eQx6Lblb0bYUPqXruKPK71Ankb5Lq7CA5MxWF+d
         Isow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ad1rlsGnkNmx4h7I5FKuCR9FtzVzIxjTxHczh5NRLG4=;
        b=lnmLGUZBaDodm8O6EzmgIYqki+L35eeVmkS2wa+1VBn7GOVZVPpoZuuZFiry2V2Nhu
         simENkZ8FJEQ35SwpSzBtSDgnFuZ7G4dBDML1bFYAfkbQZ6XNP/BhE874IhPhKyc0/AE
         Vb4pl4QZqgLsf3QmpDruRzRllRotOcb41qpDtmWoDXaxz78ojhSBLrzrDacfQOkmCwnc
         6yeQj7gZOxFxl7LAJdXVjrYEv3it7TfLTM5mOwDDXDQkzsHgWjjTXbxIYPUXqSqbR7vr
         3NkQK5j4yJfFDQr4l0+j7/XYytxKngg0Mr5nUFXMmT6Cxz+UjMGkgejUhYYN47dYbyPr
         ByVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LvOv8p1W;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LvOv8p1W;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/43] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Date: Tue,  8 May 2018 10:10:43 +0200
Message-Id: <20180508074007.842151377@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882858035853957?=
X-GMAIL-MSGID: =?utf-8?q?1599882976536049119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SZ Lin (林上智) <sz.lin@moxa.com>

commit 9306b38e42cb266f98bff6f6f4c1c652aa79ba45 upstream.

This patch adds support for PID 0x90b2 of ublox R410M.

qmicli -d /dev/cdc-wdm0 --dms-get-manufacturer
[/dev/cdc-wdm0] Device manufacturer retrieved:
        Manufacturer: 'u-blox'

qmicli -d /dev/cdc-wdm0 --dms-get-model
[/dev/cdc-wdm0] Device model retrieved:
        Model: 'SARA-R410M-02B'

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1098,6 +1098,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
