Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsuzxQ5uE+OxAsPd7zBvpgkhEOhydaR2nkUqiswJwL69srn+D/Inz6kG1wbIXvviAgMuUok
ARC-Seal: i=1; a=rsa-sha256; t=1521203820; cv=none;
        d=google.com; s=arc-20160816;
        b=oW7I1qzcMWVlnVyQ3DmKRdax9j0K/zpGnuBPeOp/AkFXsPzGSowIz10uNspgH3uYQ8
         3/g7B5fj+80SVGtTHYpV2BgWbyzkIa5UD2Xzc2J0pQ8M74vxhW0cHaJFeNztYB8iAu/l
         +m4Tq5qmKu+aS95prHM6yrshe6mjmixiCl5iiyOpV+JVod6HkBL5QaFIqRwnmlOXEn5+
         2ZM+YadQ9fpelxd/tOrFsOaNl7nYNmwphpPl6OwH/D9tZ0gRejoUtUn6EZ6NwsUm0Yt0
         8nhV1mI++uiFsSN0sVt9YSCL99y2288VbRTSsgSoP0R1JOY42RqYwsWpbJ/SbX3SBWjB
         9gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=3lhUJDnb6Evr71TICc/nq0aX0yp4oY0UabLepRLEHp0=;
        b=mv5rph35rA9q87kmttvKT0Fsyt6J/e3T8RFBwsum390PzjAlPNRmZcJQ7CBOBqEIt8
         rlW8hqqSz5JjDWhrutfbXjGO1jjLBpyZJag5q2MAm172gTKYuBf9Xe51vnBxdPx4kv1G
         RNvEwbZdC59xjJeHTib9Bzi88856Z2ft/ONk5ee3vMxZin8OiMvdSfi4c/TUMaT5Jgl/
         HKop+vl7GZT3/QuoVQUWPvReQI+TSg2HoxUH65xXxkXfVeKzX42FCM0bf+yz0otz3ezn
         74DPY4G2i4wLuSKmT49ZA7XkrtTmDE2nu/u/qdNodu+UgR4bNlvptBIYevTmf3ydrQsB
         QFIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe
	 <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Fri, 16 Mar 2018 08:36:52 -0400
In-Reply-To: <20180316122129.GA2458@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
	 <1520290344.10396.357.camel@linux.vnet.ibm.com>
	 <20180316122129.GA2458@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031612-0040-0000-0000-00000441EF7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031612-0041-0000-0000-000020E4FE0B
Message-Id: <1521203812.3503.19.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1595097817364804195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-16 at 14:21 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> > Hi Jarrko,
> > 
> > On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > > In order to make struct tpm_buf the first class object for constructing TPM
> > > commands, migrate tpm2_probe() to use it.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > With this patch, the Pi doesn't find the TPM.  I'm seeing the
> > following line in dmesg.
> > 
> > [    1.087414] tpm_tis_spi: probe of spi0.0 failed with error 256
> 
> Thank you for reporting this Mimi. Does it have TPM1/TPM2?

The pi has a TPM 2.0 attached to the GPIO.  James pointed out the
change in return codes.


+       if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
                chip->flags |= TPM_CHIP_FLAG_TPM2;
-
-       return 0;
+out:
+       tpm_buf_destroy(&buf);
+       return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);

Mimi
