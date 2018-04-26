Return-Path: <larsm17@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524742767; cv=none;
        d=google.com; s=arc-20160816;
        b=N7bdl7ATO5PlWZKIRvlC2/iEeERkbw8k8VI1DSiEdvV+tH+HulOvvtxSX+X92KAF6z
         Nmnw2adqpNj2QVst7B6U6dDLpF9dKMCYAhqLEK/ynextJ/I051OO4B/hz+PXcDkJRWCY
         sCaC/FaspdMTDPg1Qq9++/9P8XZMUqXp2tPTDHX1DwwLB4v5gMpBVQD+nOyQUegOnwVO
         Jms4Q3uCsDUGH0n6qMs2AFSDAazr1o5h8tX4+HsEz6w3JSCL+lchyM5nfBAaERI+ECK8
         uwxR7JIALsc3EoZ9llG3OKh3K6/njLZeizqqahCex62r1+ctowmNoHIZu50mjbsrxJt6
         eHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=q2Sg9QGt7ezpoeoNf+fV5oAMzgikJdvoh12RDcYz3qc=;
        b=cJM6kp9zvCRT6QEdEBR2BUeeWrDTfF7iuZIGprb4T/9aPOqaDa4P9LBXCQ49PNt7WP
         8Q1J6TST3Bq1UAGPDGElflHJ764J+xK6AIn7yZspUG+0wiMayifPJdjTZ26f4EZYF8h0
         pSsHjeqWXBVuGJPjQOZI7r1ldyTlblZLTGh4V4fs8QdtO3byBd1NuhpH1sJFfWJ1PldV
         S23C4/INN/suiY4DbF3AwyEt8Qz+y7Mx7VX3fqZKu8mgpKpXFvqqPo2F5P7MnqYoBvmA
         JIrpdV8/Ty7mTRWeHLzAb11fBDazUk92cfN7bh8qmi+E90ZVNvyZu1gqHO4RDVcXP3KM
         IBmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XlCCXGRD;
       spf=pass (google.com: domain of larsm17@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=larsm17@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XlCCXGRD;
       spf=pass (google.com: domain of larsm17@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=larsm17@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrfo8OOjbaxYbON2ogdrXiZOCKUXHtUBy1h4wFmpm90mZ7+VkGpW6iqUagrXEdVcxlAPs71Nw==
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
To: =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
 Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>,
 stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Williams <dcbw@redhat.com>
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
 <20180426081403.GA335@localhost> <87r2n25i6i.fsf@miraculix.mork.no>
From: Lars Melin <larsm17@gmail.com>
Message-ID: <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
Date: Thu, 26 Apr 2018 18:39:22 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87r2n25i6i.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598789137647329265?=
X-GMAIL-MSGID: =?utf-8?q?1598808672315199514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/26/2018 18:19, Bjørn Mork wrote:
> Anyway, Qualcomm based designs are definitely handled by both drivers.
> Using qcserial only makes sense if the interface layout matches one of
> the defined shared schemes, which currently are:
> 
> 	QCSERIAL_G2K = 0,	/* Gobi 2000 */
> 	QCSERIAL_G1K = 1,	/* Gobi 1000 */
> 	QCSERIAL_SWI = 2,	/* Sierra Wireless */
> 	QCSERIAL_HWI = 3,	/* Huawei */

It seems to me that this Quectel device matches the interface layout for 
Gobi1K:

		 * Gobi 1K USB layout:
		 * 0: DM/DIAG (use libqcdm from ModemManager for communication)
		 * 1: serial port (doesn't respond)
		 * 2: AT-capable modem port
		 * 3: QMI/net
		 */

/Lars
