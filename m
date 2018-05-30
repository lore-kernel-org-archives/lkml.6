Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeE3QoO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:44:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:42031 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeE3QoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:44:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="asc'?scan'208";a="62936535"
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Bie, Tiwei" <tiwei.bie@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Thread-Topic: [PATCH] virtio_pci: support enabling VFs
Thread-Index: AQHT+DJkllI7MbkD40qnnyH4gxudsqRI78oA
Date: Wed, 30 May 2018 16:44:07 +0000
Message-ID: <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
 <20180530192010-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180530192010-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.233.80.164]
Content-Type: multipart/signed;
        boundary="Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7";
        protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

>> +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int  
>> num_vfs)
>> +{
>> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>> +	struct virtio_device *vdev = &vp_dev->vdev;
>> +	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
>> +
>> +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		return -EBUSY;
>> +
>> +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>> +		return -EINVAL;
>> +
>> +	sriov_configure = pci_sriov_configure_simple;
>> +	if (sriov_configure == NULL)
>> +		return -ENOENT;
>
> BTW what is all this trickery in aid of?

When SR-IOV support is not compiled into the kernel,  
pci_sriov_configure_simple is #defined as NULL. This allows it to compile  
in that case, even though there is utterly no way for it to be called in  
that case. It is an alternative to #ifs in the code.

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlsO1NQACgkQPA7/547j
7m7fOBAApqkdKjNkDMyc4Fo/KLviVZCiv3VXJ6ftdR6iQcJPCj4fBJQkHYcs9hoH
FUc4GIuo6hFl84OgsbvVDfCQFg0yaO+rZp2lSNjTrEQ+By6Oh4vXe6wCPcu7/sDE
IDFR04g3U5dm/HohkQbbcNW/Um/CcBLdHgmJXWpsifNr8j+Au3SafiFbalfv7UFr
WUSGPKwCPzGJoGYIia824sWkUI/HdGRrhvxXefnq3DSObrxxX+Hj7lqxgfg7r8c7
CfZ0NmeykKIyuGLHZLyKhOispM3cw9145QiquP8tHVnvxUTqrYNhzMiSZTYqsBY2
VQSGCf+paHgFPIKqJIZpNIAN/A3YKynFZA+qq8XrDr5AT5UA9HrLbe8fheooamV5
r21k4+05AIwDOTV1AlYMHdpzUTNs8SLe5mwNL+4RpvQlKV3Kptv2NFzv13fmSPEo
SHcRexSpBP4eSxVOIhW3j64M4aY7vg5MQshD+geqhgA4wVpb6Wqct3GHdnxqSoEt
z5wQrQD8jB8glt8HpIrWzMDyp774QKYnqlpddA6U9keUYP1NS5iNMzbCdT2/TZIx
s266G3ckoi0E5qs72bEgYSyd2g4yvmLl7vZ+FWJqpypFUE4Dj7cbGXlBu4Ib8haq
IZBRPVopLACSRpAl2exZXwnT41mvznompRSHxigfe79w64JHwgM=
=kV9d
-----END PGP SIGNATURE-----

--Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7--
