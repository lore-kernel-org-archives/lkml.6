Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/VBjWJyJo7EU6mrKABlfD48owhFTZu+HdHoF1nBvzSp8COQ5j97yUJ+6XLEabuhsnavzRM
ARC-Seal: i=1; a=rsa-sha256; t=1524228093; cv=none;
        d=google.com; s=arc-20160816;
        b=ZGHghzHkRmL8e58AA5MZeJRatT3MeZ0hE5rpasKb3SwRneVoJoTjjEVYtDJicAA6ju
         nT2+C6LwRBf61tLDo65xwrmHe+mwq6xvnTKm7BTqU9LeG3LN2sm37u9HXSouHO0MkZi4
         BXAvaVInOC/H5pt7UnSrOWMHWdNgtVbkvtBpdol2Co0lYe/OSoreg5gs6eY39HUVgA7N
         Da5nxLoV+jNRKrMaTF8rtXjxMAQrVxJYQN0qEJzmi+sLC+HuxR1t9nbZ/M8bCfSjRUjA
         9OrOCuyfvKBUJSpJ4cOz//K14q5nh0TDys5yzm989mjBkK8Gtvy6cG5NENitsBwq2VMT
         Mx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=iMWL+bsgoIjXZai/Dn6xnH8wiwYdrPvXnSl44IFhWKM=;
        b=LCVRXwkcWkWCHZag12WYumRDDYo4n6qPcaB00KUZhTm6AdZwvmMZimWA3jC7p1Fgpr
         bvus1RTapsicVQ54uWF2k1jwWxydYWF/ttN7kesSSQ5W0AW/txhuK/zNVL5DXgQnIzHc
         0eeuTVeVZz/OJ3PX36uLNFpbaDhO+LCKFvlKeo3tWbc4OW9yUYhkvS47wr+RvsGBn6wI
         LS4eEkklBJuHPpHzPtgbVmHE+Z1J3WOv6WeqbRrn4LTqwd3TiWVrCSVx+P7hw2hCoJ3U
         crrK7QJLb9ZTzX6rjH9RWG9/KS9ngDlIn68C3ZItxXIqDxcg8bVVa9ksbyvqHh9W4kiw
         APsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="49449845"
Message-ID: <1524228089.21176.469.camel@linux.intel.com>
Subject: Re: [RESEND][PATCH 4/4] NFC: fdp: Fix possible buffer overflow in
 WCS4000 NFC driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amit Pundir <amit.pundir@linaro.org>, lkml
 <linux-kernel@vger.kernel.org>,  linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Christophe Ricard
 <christophe.ricard@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, John
 Stultz <john.stultz@linaro.org>, Dmitry Shmidt <dimitrysh@google.com>, Todd
 Kjos <tkjos@google.com>, Android Kernel Team <kernel-team@android.com>,
 Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Apr 2018 15:41:29 +0300
In-Reply-To: <1524045904-7005-5-git-send-email-amit.pundir@linaro.org>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
	 <1524045904-7005-5-git-send-email-amit.pundir@linaro.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077982406018192?=
X-GMAIL-MSGID: =?utf-8?q?1598268997667197465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-18 at 15:35 +0530, Amit Pundir wrote:

> +			if (phy->next_read_size >
> FDP_NCI_I2C_MAX_PAYLOAD) {

> +				dev_dbg(&client->dev, "%s: corrupted
> packet\n",
> +					__func__);

If Android people would follow the kernel in reasonable time they may
have noticed Dynamic Debug functionality and how it works.

In this case the __func__ is superfluous.

> +				phy->next_read_size = 5;
> +				goto flush;
> +			}
>  		} else {
>  			phy->next_read_size =
> FDP_NCI_I2C_MIN_PAYLOAD;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
