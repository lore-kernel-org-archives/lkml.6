Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELsISqfVzWOa/Aern3u71RsZRcyL88vPWaIqVVdjzo5EJrN3u84+9aSK/NrvDavfHdW8sTmg
ARC-Seal: i=1; a=rsa-sha256; t=1522140091; cv=none;
        d=google.com; s=arc-20160816;
        b=yqnMGwPoN/hUF4gxlYbBRK27sdtJ54uUSU7sAOhNhtT1r6e6CYCdYoQyAPS5NmNbyZ
         GjFzTO9jkepH4Vmi66PBAlr45z6Ao8ddvRqLZBLAPMmNVdXkbnwxVP62FvPo36TN69Cy
         dCDZhAIUu/LiD/Jvwq1180T+Jpbm5ST1u21lQ7XQzZCKFZuPXNWflUs1jiFXqLYgV7UT
         2DrGFGiHXUi2x0U0lAxCB3z/OkYOBXKd6BshEIcWn46ELra9iL0ar07PLq1D/H2N8ua/
         9S/Kvxs259TAqeZ7dw3Xc+73LtaNkOYGMCiVUTsgck5x2cZM+ny3ipphZY3oUUAIBMia
         b82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=55GG6gfGmw57DkSLpSc1PubNSVsOeYxYxYBSgoglMSw=;
        b=YEFZ6paLWiSbP7Fd/tQwbgIxyWJnHW9k5xdkf6ptBjd3kCAJvUt594fOdInAtLeC3C
         H5BPjmsn3xKL0rxBu3AITKSxBU+5sFiwVEBRQps0o9Wy+1N50csaJvH91o632zxduGOq
         wvSxWHTY4yeLpbT9d4g0bnGvbNzyqZFo8MskkgB5YPw+CpOm42Ja776nNpTSkn+GGl6s
         dFBJhl3R+ZNQ5Rq390cqsaIsjZb1JoFVdv9HaAKPfuK7PkLHDmN9COCeyL8d1fvSO6IB
         cZZ3N5JV3ItS5E7Fa/w2CkxAWTftoURE5m8sWNCBJWHTXcsHvCP98U/6ftTPGjg7Bt+n
         5tVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 09/23] staging: rtl8723bs: Fix alignment in rtw_wx_set_auth().
Date: Tue, 27 Mar 2018 01:41:01 -0700
Message-Id: <20180327084115.16129-9-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Sgd3PlXF4oQ75usKpgIJVJpqN4PHRRJlm800Gs6tIRGMb8Pq31p
 /q+/+Q63ICLXxivBIG0D5RZ7U5cgglx7d5Q7GGg2Hyky4x4ZERdhcZqYN/ywQd4qj4CzwRr
 sujhL9hLfO95kTWBkZcAPKC+o/8+2OgTOqw1fvTowG3xOhLk8eZi+ZBVw7btoy4Y62YX0oh
 Yt9CnhRkxhCYVu7lwwtyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xvkvmh5gRDI=:UZKRcKH3vFWH4lkSiHg/Kx
 OFtWJaWrTzxyURpAunHVQgDat7wQXrtiDLseEd01L3cCgHoiNdTgmqhQGyvInlUdC0gk/iGdW
 gb9zuFMftg3F0ebiRxlUaIdwqPS353jASoriW2XKwOFpqNTXCq8ZtvzgQTn5r3MyHgBG7byMK
 e1ay86KNKEUkiMIpL2nqYaHCCMdqxnnS6iuKBbIIOXvxy9ri5IYkLYPq9gsM5JDcofUslmVv7
 EqwD1rptDGAl7pGmgjEmce9IXEfwiELn5XGn+xK5jmtnJqzai68q6J2ZevQkRUDedSliLUGu+
 Pjvl5jZojBFK2+Jk4l29POGTfczigTeRjst+LacqGyBNAX+SobQsSK+rEFrZw/swUK6jm+zT+
 qMrgofY4L6/FjubF5pTw0OWbujjqprkxbwo2DLLogKWVkv8RgDZ6GbEbfZdrftarT+gTma/f4
 p0OPrSjW0of+roBoMZy2dzrJrZ6ba4mX6zwvWWlgMhdKmmGybJz00z6Ydka8O6seCVhyXBMM7
 uf2xbjqYbhqxqWbop3Ft6gaf9tdGu+cuciYGb6u5yRIbUqn62yY/uTKFUwFD6tIrsLWbKiDA/
 JruvN1G9GGZB9ka62UUZEIb0LOYtZGLBtjtJbtjotM4T4NtAUKtSssV1pdGHP23PfICzqgBR/
 e8+XJAlmVh14DGzI73mc22KC8MdSfE7NDfRQgYfBuRg+DmBgR53BrlEmqDq6bhsi9/zny6YCE
 bniRCKJM/0NcJA6FgYyps6uMi6JRuAPuBCsbmQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079568855815893?=
X-GMAIL-MSGID: =?utf-8?q?1596079568855815893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Realign the function parameters and comment blocks to match the kernel
coding style.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 1cacd7fff052..32dcee9a1451 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2131,8 +2131,8 @@ static int rtw_wx_set_gen_ie(struct net_device *dev,
 }
 
 static int rtw_wx_set_auth(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_param *param = (struct iw_param*)&(wrqu->param);
@@ -2189,7 +2189,7 @@ static int rtw_wx_set_auth(struct net_device *dev,
 	case IW_AUTH_80211_AUTH_ALG:
 		/*
 		 *  It's the starting point of a link layer connection using wpa_supplicant
-		*/
+		 */
 		if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 			LeaveAllPowerSaveMode(padapter);
 			rtw_disassoc_cmd(padapter, 500, false);
-- 
2.16.3
