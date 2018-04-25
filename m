Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-778318-1524664259-2-7950432884323081515
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524664258; b=GDuPRuyGToQlU4woh4q3p8OjEMXpa+znPSdC7cWoB1VOYEPm6P
    ThvhQZzp3B3eF8EeX+JNCxX04f7haWRWGG8UVaOvq3khL0sr2JvSnGKYpW/acGHO
    +/DSbl+Xw8rdXgTNOs2RPYUtXdw9BL4pGCXtSzWSXoPvIM1muC5zT4l8b5+STBb7
    PAPFwGJ3bienwq9hAJ4KYxm/z/3HZZcP6ctDmv5vOwzfINwSFDhzhG5HRtYtHg/0
    3dLt7Faa73dnmuTfStZq4I1vQlLs4CdXTSil3ABhlrYY8SjqBjgMRL+RX4JRMZsG
    JlyceAR3wWML/Us2pPYC+VO2R37nC+e9MflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524664258; bh=b5D36
    gR+J3a/BmbNduHRRhYZnJ7q8al84L8sHxcpZJI=; b=g9KgTA/jV6OSqasEAh15j
    9Blg51DgtoKkU3t5NvXiRKYARui46Yvn+WuygOJ8NnbisZApQWhkqBlnp77+L0JI
    RFk+zjcRbVVzJkeuM1+8T/oF9EUUTrF26ouxL81Q9Rf9lng6e8Ly1nmb+X8GC5s6
    IZ86rS82a7lYBttfDz9IlbbhfdR0n6hIr3SH1iCqmVQ3OdyU1yvjFkgCXFzwXnwO
    0pmUru0KoOqoKGV/nmPl3AxC+RKIjJYykbi1UN44CqXho69z+CsQD2ClWae0LSWz
    xbuZonelpofcABheHoa+eBaUPF6pMSCPiXFK+bdz7O3hl4UPgy8zgtmjLH07D0Lo
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOTglQeQu10pHHIb0/ZkTiLnsMZ7DEXWlQkUtqe0waLZ5fA4W+67hpQjBRdH5Eop2b941bMzg2g0/CLvbtHdTvZORxABGVINyLeCmgPYguesNYPWJwqm
    FGJFEHjht8KMohPwyioNq3Wyw/6ypbDs1dbpMMzQvJTUWCkiaFltPEtIeYum4St71X555fufdeaiEvs2Nwitknlx4qX3Bpfz5I5X8iiSQulKnT3Bilg8nfOI
    KUjb+rrtifbknua4M/M8ng==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=0RNbjMaCEXFTfO9-O4UA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 25 Apr 2018 15:50:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] staging: ks7010: fix ks_wlan_start_xmit()'s return type
Message-ID: <20180425135045.GA28703@kroah.com>
References: <20180424131824.5164-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180424131824.5164-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Janusz Lisiecki <janusz.lisiecki@gmail.com>,
 linux-kernel@vger.kernel.org,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Quytelda Kahja <quytelda@tamalin.org>,
 SUNIL KALLUR RAMEGOWDA <kallur.sunil@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 03:18:21PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/staging/ks7010/ks_wlan_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch does not apply to my tree, please rebase and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
