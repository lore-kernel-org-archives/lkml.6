Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2795102-1520937340-2-1597905503530569180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520937339; b=L8FJ4NN5mu1uy2D1oF44rJomMdYnYqOQemQymzpSaDWhysX
    tjT9gByk9dqhNn5UAyNjs9DOZ6AHLSJfXi+YBKhG6z5IFA9El5hCcNENHjLEZ4NR
    7dOL7HdnpNI3ljrCrtn80ObsLX+3x0dtBNPdboXR7rC+y1H3rm7WiU7sw/ovm9Fw
    LGaRBLv4xC2O3xUjnjnuNrafwmh1fGsa+nUx+hbC/pYh3ILc3cyoyTr6ir1vTde0
    /SiB1+y8yu5PLUwksJSzoocJ+m9vGOMkMwp8NxJKsnOq0M56vY3wsCJnlFcYO9jW
    rkl4gd6sY+w88AMzhJ0RW7pj5t2ah20cgh0hEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1520937339; bh=j5AnKWXsR6eHJq7K428EJi9ylyNjiPXvo5kXgcoAE+k=; b=t
    UALv8UHwmWndvjFgdz9+l0nB6r8Ms22KCVH+aJ2b+BStlrwzREjaiZvO5+VYMJjW
    K93N2qvqGUdhi4ippcYAX89jgCfFj2IsqHZ/M7Wec8Qvn1pEpFO6x0Rx+1a7juUs
    DKB3+SDXXdWsEn3srN8706T8PEYxbhNxjoPNGsbqUqKg847ilkBu0D8gHbH082lW
    sVZLExyNO+r7UtgSwgWzZTKm9v96S4rNtO0KFTEHD7EL6NQ1rGr9mrwIJet41vOO
    2hIK5WAGnfA7ZATyLmO8YNMuTVjF7diBThS+fhhg7lXouBnOubHisjkqaYY5f9vm
    2yz6jZyGS4l5l6sDFwZBg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Auth-ID: siepeng@mev.co.uk
X-Sender-Id: siepeng@mev.co.uk
Subject: Re: [PATCH] staging: comedi: adl_pci6208: remove redundant
 initialization of 'val'
To: Colin King <colin.king@canonical.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org
References: <20180312233605.8643-1-colin.king@canonical.com>
From: Ian Abbott <abbotti@mev.co.uk>
Message-ID: <f3155983-cf67-2f78-f0f5-7a3acb041ab2@mev.co.uk>
Date: Tue, 13 Mar 2018 10:35:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312233605.8643-1-colin.king@canonical.com>
Content-Language: en-GB
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/03/18 23:36, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable 'val' is initialized with a value that is never read, it is
> updated with a new value again after intitialization. Remove the
> redundant initialization and move the declaration and assignment into
> the scope of the for-loop.
> 
> Cleans up clang warning:
> drivers/staging/comedi/drivers/adl_pci6208.c:61:15: warning: Value
> stored to 'val' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/staging/comedi/drivers/adl_pci6208.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/adl_pci6208.c b/drivers/staging/comedi/drivers/adl_pci6208.c
> index d39b4eabce8d..e21840e9002d 100644
> --- a/drivers/staging/comedi/drivers/adl_pci6208.c
> +++ b/drivers/staging/comedi/drivers/adl_pci6208.c
> @@ -58,12 +58,11 @@ static int pci6208_ao_insn_write(struct comedi_device *dev,
>   				 unsigned int *data)
>   {
>   	unsigned int chan = CR_CHAN(insn->chanspec);
> -	unsigned int val = s->readback[chan];
>   	int ret;
>   	int i;
>   
>   	for (i = 0; i < insn->n; i++) {
> -		val = data[i];
> +		unsigned int val = data[i];
>   
>   		/* D/A transfer rate is 2.2us */
>   		ret = comedi_timeout(dev, s, insn, pci6208_ao_eoc, 0);
> 

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
