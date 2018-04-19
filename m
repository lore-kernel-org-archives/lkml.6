Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2811296-1524131283-2-8010978165934254533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524131282; b=ksYRBAKvwYhiU623Dx9eVvsEwdoXEZcyVjv2+YcVLe76dszN18
    okZUuHIyzK4SckJs0I0BTTMdYpeJJA3cV1Sh1t9bYBN38RJf5zO3Zt7kvmfuRbb4
    8pfcZiq9j71cFe3e0zuYDsPDRz6e3op7428lPE6abZK4WIgoqTygkIaEHwV2oy9E
    MaeP9iFfSIoRZz15S3fLBSVvw2x05HiZAQ8O/s3dhEQj1dNqtDA3HS28O4ZPYcnl
    DboxvoJiDPNLeavsn36HRLbgwSpinXi6wUo8xTGLpcIbw7zmeSppWmmN7J4FYBfZ
    TzZaqY9hE9qzilmNMrvimX98JKWhKLLY6g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524131282; bh=fJpYo
    fcXyScbp9CH9JMWLO+Ndf/JtZhjy3nlDYPvkU8=; b=gIcTGSATA0F0JawYYKTP8
    5szX3g5ufeyQEmKLXOUTArMEp0Za9PF+HAC+EFaJZMZXFcXbRjwRw1j4SZDUZTLb
    2FY2QQ1LXNEcisTeN1Uxg5+aBrI6Ploa+WL9Bpfbr6xDdf5/1nAsUGVMDvVv3DC3
    devDOCrQFjNrurhHu5KUaeLPw6J5vdIVzZSIUYK0O1NhpohCmPGXXL7TErp51CeL
    l3uOQv3hloLL4V6CKuvXs4MbnRUZw235V5j9i3FRQgth0MSQhpGwxwiOp5sxBbO4
    jlZW0sZNiIbUaXKfRzs1rnoSgydRpvV+PSppjVrORsxmpf8UERySU/eIlG8YrJKQ
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMwOY3GLdR59hWx6akk5zfi4/I3Uumoo6VTSmBQB9021iwNN1KjWpJxO1xvgqfTAQ6W3BjAt0G4EEnK0JV84ZjEq/TvRbsx3EakK+V7kQB6M2nY4P1xF
    RrYW91z2FLABEKM4gInyTil+RcZpltTKG2lwnOl4GJJ1uhRpHVT72jpnd3kVF9Ro12iQAJLGKkMGONK096wptJSaodEYrkVpf0bf+/ssIvEL9mwauNnryCN0
    9tiDX0oL1FwRWUNl5QR0Ow==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=c9Y5ZOtAOPp4AccrT4wA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 19 Apr 2018 11:47:48 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <20180419094748.GA2383@gavran.carpriv.carnet.hr>
References: <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
 <8eba67bc-7480-f07e-9022-1aa19a4881f5@smarthome-wolf.de>
 <20180325142414.GW31333@gavran.carpriv.carnet.hr>
 <849553ae-5f62-0a06-f545-4d0fbaa513c3@smarthome-wolf.de>
 <20180412171504.GU3257@gavran.carpriv.carnet.hr>
 <61ce1de5-6562-2843-7e63-6a15c16b42a8@smarthome-wolf.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61ce1de5-6562-2843-7e63-6a15c16b42a8@smarthome-wolf.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 11:25:19AM +0200, Marcus Wolf wrote:
> let me know, what you like to have. For sure with just one station and
> no other 433MHz equipment, options for testing are quite limited.

I can get Rpi3 and with two shields test 433MHz communication between
Rpi2 and Rpi3.

-- 
Valentin
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
