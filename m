Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeB1OqT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:46:19 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeB1OqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:46:17 -0500
Date: Wed, 28 Feb 2018 15:46:04 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1.fritz.box
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH v4 3/3] PCI: endpoint: pci_epf_create: remove goto
 labels
In-Reply-To: <20180228133323.GB21854@e107981-ln.cambridge.arm.com>
Message-ID: <alpine.LNX.2.20.1802281440001.31400@5HSWXM1.fritz.box>
References: <20180228130719.31218-1-embedded24@evers-fischer.de> <20180228130719.31218-4-embedded24@evers-fischer.de> <20180228133323.GB21854@e107981-ln.cambridge.arm.com>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pB8kHlunznSySrjjh5R5X8bB2YGnmDCc40YLsK+HjFSS3y591e/
 kGZDJeWhxurPicaiNVtHbQ6J959YzCGXnrOkuuf2a4CIxuwvldX1LgaHvW5VsonanEM/vds
 sHWyJZFKfe79pg4VfSfzCcCkNpzHt9RVrl/juZzyq+V3gIEBj+BPF5Z6egiMNLRdgHP26xb
 j3t0+7yne2mYFndPFtPOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:itIzN9eriDQ=:IvRgFKVuXm1kyXkxbuPJ0p
 i1s3K8OHdFungfzZPc9invioHkr2Y0bUr2WUrZgVs3jDcc/ihXfmiOziiQVElbGqcK7Nx5Q4Y
 UCDY1+8az030clvQ0eis5Qx+dg+6NbFIO5bJtwpoiiv2p6HwpefsFiZQSVuvIE+dl7RTBr6IT
 qhIMReWfz+L6xsnC8tTtvuDGCCPRSUwWTV1nq0ANQrJqsmLZkh3gwZnIuA9o1S5q8nTyqRBxu
 0KNjkhReE31+kh8VjCsynx9inFZljYOA1ODCo/ePncLBOt6c6/+Nlvlx4RNa+HxphfaxWjXu8
 MSThQofRZMIv0S7Dlb93nF8FO4dAE95Ao/LxZpU0WQAUoMs4W8BK2MXR3UF0fRfkiHr2hMXJq
 WGwiAXhejmxZy9BNNWaLGMplXAtuYoxIMTk/jdjx9ulHcWB+NOGgGUsMqxxwaDKIqKgtVim4/
 eVMYm3omcSmNfYEowG7zDSUkoUT3CHg2AQc0tzzOenI69ipad7ZYgO8iLac4inMg/++qPRhDj
 qK4hBQS4S3JZ0dOk3BCWPBLiMEalVDEXAU7k3Uo6DLQ3ZnV144LGqscGHhfIVEr/4m9fntUud
 AKCMex3Ti8grm8UkSbvz1S2/NeHB/mOpjPkNRsPV9ahYZy88kB/acR69jf7ndhTKMr6UFMW2G
 3mUpqHHNj+Mze3VbQEcWynHsebKVbYt2JMsV+borWx+eGMQiL6XnNA268MNy8jcyAkgSVcGax
 Z1KRpYG5uNCYRMbsBfb40O+RYdhjayLdgrdVlTHJrYAocLB9IHwK1NilDgA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon and Lorenzo,

On Wed, 28 Feb 2018, Lorenzo Pieralisi wrote:

> On Wed, Feb 28, 2018 at 02:07:19PM +0100, Rolf Evers-Fischer wrote:
> > From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > 
> > Removes the goto labels completely, handles the errors at the
> > respective call site and just returns instead of jumping around.
> > 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 30 +++++++++---------------------
> >  1 file changed, 9 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 1878a6776519..cf2c4f6590a0 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -203,16 +203,14 @@ struct pci_epf *pci_epf_create(const char *name)
> >  	int len;
> >  
> >  	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
> > -	if (!epf) {
> > -		ret = -ENOMEM;
> > -		goto err_ret;
> > -	}
> > +	if (!epf)
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	len = strchrnul(name, '.') - name;
> >  	epf->name = kstrndup(name, len, GFP_KERNEL);
> >  	if (!epf->name) {
> > -		ret = -ENOMEM;
> > -		goto free_epf;
> > +		kfree(epf);
> > +		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> >  	dev = &epf->dev;
> > @@ -221,24 +219,14 @@ struct pci_epf *pci_epf_create(const char *name)
> >  	dev->type = &pci_epf_type;
> >  
> >  	ret = dev_set_name(dev, "%s", name);
> > -	if (ret)
> > -		goto put_dev;
> > -
> > -	ret = device_add(dev);
> > -	if (ret)
> > -		goto put_dev;
> > -
> > -	return epf;
> > +	if (!ret) {
> > +		ret = device_add(dev);
> > +		if (!ret)
> > +			return epf;
> > +	}
> 
> This is ugly, sorry. I should have been more explicit, I prefer
> this construct:
> 
> ret = dev_set_name(dev, "%s", name);
> if (ret) {
> 	kfree(epf->name);
> 	kfree(epf);
> 	return ERR_PTR(ret);
> }
> 
> ret = device_add(dev);
> if (ret) {
> 	put_device(dev);
> 	return ERR_PTR(ret);
> }
> 
> return epf;
> 
> Please send a v5 and let's be done with it.
> 

Thank you for your feedback. I agree with you. Hiding the correct return 
value under two levels of 'if' is not the best idea.

I will send a v5 containing the proposal from Lorenzo. There is only one
difference: We must call 'put_device()' in both error cases, because
we have already initialized the device before. We had also jumped into
'put_dev:' in both situations before.

The modified code will then look like this:

 ret = dev_set_name(dev, "%s", name);
 if (ret) {
 	put_device(dev);
 	return ERR_PTR(ret);
 }

 ret = device_add(dev);
 if (ret) {
 	put_device(dev);
 	return ERR_PTR(ret);
 }

 return epf;

Best regards,
 Rolf

> > -put_dev:
> >  	put_device(dev);
> >  	return ERR_PTR(ret);
> > -
> > -free_epf:
> > -	kfree(epf);
> > -
> > -err_ret:
> > -	return ERR_PTR(ret);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_create);
> >  
> > -- 
> > 2.16.2
> > 
> 
