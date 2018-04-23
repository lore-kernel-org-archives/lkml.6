Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932156AbeDWRd3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:33:29 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:22862
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932107AbeDWRd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:33:26 -0400
From: Long Li <longli@microsoft.com>
To: Steve French <smfrench@gmail.com>
CC: CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 3/6] cifs: smbd: Avoid allocating iov on the stack
Thread-Topic: [Patch v2 3/6] cifs: smbd: Avoid allocating iov on the stack
Thread-Index: AQHT1oDbxi07lcg1S0+HlWpTjDWyoKQOg2SAgAAhwvA=
Date: Mon, 23 Apr 2018 17:33:23 +0000
Message-ID: <SN4PR2101MB0733595DB7FC0A122ADB9128CE890@SN4PR2101MB0733.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <20180417191710.14855-3-longli@linuxonhyperv.com>
 <CAH2r5mv65CGR04f3Z20aRBufisPon5Ptvqk++zii3YT=GN8epQ@mail.gmail.com>
In-Reply-To: <CAH2r5mv65CGR04f3Z20aRBufisPon5Ptvqk++zii3YT=GN8epQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:c::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0814;7:Hx405evvgsnBe7nPv6Dz0Tm3F9caqrVDV5n+NT12wPq1zQrx1MwZSR0gtNfaSqqueZjXs8sE47P0IEB875rUKyjQsrgObDVFKlV0XTUFrTFCuiwyB+UJ6JMA3t9qRBMmu3xscva3QLyPSlHkBwFm/mMjgfJ5fipfCXp0esPbfS5hJ6QqUGuyVhgPrDcXFiLMMLiVsHBMykZdmVwM66S46AYgysfaSJaw5OquLlJ7tKq7Nec8zY3AAjxuqm4brRnZ;20:kP6MBE96iPHyLUzuEIuK90Ii/ZB839RK+eWKtPNHhAuiiJTeqlnxpkYvq3u6i9tk9I8Dkxy3sbokXpSr8HQNOgdoomNkOkbInslY/Hqi4zlTW3CNt1LgWVveGaJtPmNiLGhOepU9WhvI6Fm3jPcBJwPDN8RCabaMCDluwCmqeLQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:SN4PR2101MB0814;
x-ms-traffictypediagnostic: SN4PR2101MB0814:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <SN4PR2101MB0814DBCC49DD99A0549A3F42CE890@SN4PR2101MB0814.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN4PR2101MB0814;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0814;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(11346002)(446003)(102836004)(6506007)(53546011)(10090500001)(6116002)(2900100001)(76176011)(186003)(59450400001)(3660700001)(3280700002)(8990500004)(99286004)(2906002)(7696005)(33656002)(53936002)(9686003)(6246003)(6306002)(55016002)(86362001)(575784001)(86612001)(39060400002)(1411001)(966005)(14454004)(478600001)(25786009)(10290500003)(74316002)(5660300001)(4326008)(305945005)(229853002)(476003)(46003)(6436002)(22452003)(8936002)(81166006)(316002)(5250100002)(6916009)(54906003)(7736002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0814;H:SN4PR2101MB0733.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: +LAndyQe6QY9rccWuXoKbvYRNdOe2RtQy+jPGX8z3LSgWzr2LBXrKN6kbhoBGdj0eg+PuMtHvggJicuEfxMgQiusHX32YFzTRPiIA1jVmc3GZygPbwRPevkXi46tPX3VljoozEScLOoKJ2XnGd2On9s8vBoz07GMhGtw2OkEVcz97R2iX9x9akl1DxTnf6CD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fc1cc1e7-9706-4d7a-ad42-08d5a94050ce
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1cc1e7-9706-4d7a-ad42-08d5a94050ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 17:33:24.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0814
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3NHXcjn024795

> Subject: Re: [Patch v2 3/6] cifs: smbd: Avoid allocating iov on the stack
> 
> Didn't see any obvious problems, but can you fix the checkpatch warnings
> and resend to the list (I am more concerned about the last two warnings
> rather than the first one).

Yes, I will fix it and resend.

> 
> $ scripts/checkpatch.pl 0001-cifs-smbd-Avoid-allocating-iov-on-the-
> stack.patch
> WARNING: line over 80 characters
> #60: FILE: fs/cifs/smbdirect.c:2106:
> +        log_write(ERR, "expected the pdu length in 1st iov, but got
> 0x%lu\n", rqst->rq_iov[0].iov_len);
> 
> ERROR: Prefixing 0x with decimal output is defective
> #60: FILE: fs/cifs/smbdirect.c:2106:
> +        log_write(ERR, "expected the pdu length in 1st iov, but got
> 0x%lu\n", rqst->rq_iov[0].iov_len);
> 
> WARNING: braces {} are not necessary for single statement blocks
> #69: FILE: fs/cifs/smbdirect.c:2112:
> +    for (i = 0; i < rqst->rq_nvec-1; i++) {
>          buflen += iov[i].iov_len;
>      }
> 
> total: 1 errors, 2 warnings, 65 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-cifs-smbd-Avoid-allocating-iov-on-the-stack.patch has style problems,
> please review.
> 
> On Tue, Apr 17, 2018 at 2:17 PM, Long Li <longli@linuxonhyperv.com> wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > It's not necessary to allocate another iov when going through the
> > buffers in smbd_send() through RDMA send.
> >
> > Remove it to reduce stack size.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/cifs/smbdirect.c | 36 ++++++++++++------------------------
> >  1 file changed, 12 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c index
> > b5c6c0d..f575e9a 100644
> > --- a/fs/cifs/smbdirect.c
> > +++ b/fs/cifs/smbdirect.c
> > @@ -2088,7 +2088,7 @@ int smbd_send(struct smbd_connection *info,
> struct smb_rqst *rqst)
> >         int start, i, j;
> >         int max_iov_size =
> >                 info->max_send_size - sizeof(struct smbd_data_transfer);
> > -       struct kvec iov[SMBDIRECT_MAX_SGE];
> > +       struct kvec *iov;
> >         int rc;
> >
> >         info->smbd_send_pending++;
> > @@ -2099,32 +2099,20 @@ int smbd_send(struct smbd_connection *info,
> struct smb_rqst *rqst)
> >         }
> >
> >         /*
> > -        * This usually means a configuration error
> > -        * We use RDMA read/write for packet size >
> rdma_readwrite_threshold
> > -        * as long as it's properly configured we should never get into this
> > -        * situation
> > -        */
> > -       if (rqst->rq_nvec + rqst->rq_npages > SMBDIRECT_MAX_SGE) {
> > -               log_write(ERR, "maximum send segment %x exceeding %x\n",
> > -                        rqst->rq_nvec + rqst->rq_npages, SMBDIRECT_MAX_SGE);
> > -               rc = -EINVAL;
> > -               goto done;
> > -       }
> > -
> > -       /*
> > -        * Remove the RFC1002 length defined in MS-SMB2 section 2.1
> > -        * It is used only for TCP transport
> > +        * Skip the RFC1002 length defined in MS-SMB2 section 2.1
> > +        * It is used only for TCP transport in the iov[0]
> >          * In future we may want to add a transport layer under protocol
> >          * layer so this will only be issued to TCP transport
> >          */
> > -       iov[0].iov_base = (char *)rqst->rq_iov[0].iov_base + 4;
> > -       iov[0].iov_len = rqst->rq_iov[0].iov_len - 4;
> > -       buflen += iov[0].iov_len;
> > +
> > +       if (rqst->rq_iov[0].iov_len != 4) {
> > +               log_write(ERR, "expected the pdu length in 1st iov, but got
> 0x%lu\n", rqst->rq_iov[0].iov_len);
> > +               return -EINVAL;
> > +       }
> > +       iov = &rqst->rq_iov[1];
> >
> >         /* total up iov array first */
> > -       for (i = 1; i < rqst->rq_nvec; i++) {
> > -               iov[i].iov_base = rqst->rq_iov[i].iov_base;
> > -               iov[i].iov_len = rqst->rq_iov[i].iov_len;
> > +       for (i = 0; i < rqst->rq_nvec-1; i++) {
> >                 buflen += iov[i].iov_len;
> >         }
> >
> > @@ -2197,14 +2185,14 @@ int smbd_send(struct smbd_connection *info,
> struct smb_rqst *rqst)
> >                                                 goto done;
> >                                 }
> >                                 i++;
> > -                               if (i == rqst->rq_nvec)
> > +                               if (i == rqst->rq_nvec-1)
> >                                         break;
> >                         }
> >                         start = i;
> >                         buflen = 0;
> >                 } else {
> >                         i++;
> > -                       if (i == rqst->rq_nvec) {
> > +                       if (i == rqst->rq_nvec-1) {
> >                                 /* send out all remaining vecs */
> >                                 remaining_data_length -= buflen;
> >                                 log_write(INFO,
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-cifs"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at
> >
> https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.k
> > ernel.org%2Fmajordomo-
> info.html&data=02%7C01%7Clongli%40microsoft.com%
> >
> 7C23fbdbb0598a497f624708d5a92f6435%7C72f988bf86f141af91ab2d7cd011d
> b47%
> >
> 7C1%7C0%7C636600943380887988&sdata=imh9cWDQQEXqxHdUrCuEykgiLfKs
> UAl20jB
> > yPOS7FrI%3D&reserved=0
> 
> 
> 
> --
> Thanks,
> 
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=02%7C01%7Clongli%40microsoft.com%7C23fbdbb0598a497f
> 624708d5a92f6435%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63
> 6600943380887988&sdata=imh9cWDQQEXqxHdUrCuEykgiLfKsUAl20jByPOS7F
> rI%3D&reserved=0
