Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965494AbeBMSnW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:43:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35442 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965415AbeBMSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:43:19 -0500
Date: Tue, 13 Feb 2018 10:42:21 -0800
From: Dave Watson <davejwatson@fb.com>
To: Stephan Mueller <smueller@chronox.de>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: Re: [PATCH 14/14] x86/crypto: aesni: Update aesni-intel_glue to use
 scatter/gather
Message-ID: <20180213184221.GB2122@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
 <20180212195128.GA61087@davejwatson-mba.local>
 <54235286.FU8BX9VrCl@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54235286.FU8BX9VrCl@tauon.chronox.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::4:5f28]
X-ClientProxiedBy: SN4PR0401CA0012.namprd04.prod.outlook.com (10.171.32.22) To
 DM5PR15MB1756.namprd15.prod.outlook.com (10.174.246.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e1562b5-1aad-4750-e92a-08d5731186c7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1756;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;3:RiJh9AO5yKbf3wiuhNk/XoCzDJR2iXlX+9Zr+Y2cmhEG9JOKhniCk1tl0ACYD8e5nl7Wi8aIQwCAayqi146Pb3AgUgEFsvFGvG1NXZOoqwuSVqKtLQLXc6jsm6YAz/ytushXsQy7CQPFndxntgAHveFE9QugFByDkZqc6GeYql4ol0qxVaG/EpR3Jhectd5OTTCp+Vz8uwtC3rGUnQ/GWcph3V9lUSMiXtSY79uDqlsAxnZKoyY3KZkjdaA4ZeuZ;25:pnOE8FHJ8kYlyDsJb0ipU4GUqBEKtap+wu+tYCCem+Eq3QFpEsBhKW/rXInJf1J0RhPP3ggiyAq96/630/waq4vq6W07wzTS0Z3ag8TVJMl5p3WkbzLaIQpZwAEZxlokThBnmI1rk+oHOSiWe2zhi9uanUO0vwwHFYQXhHD0aaDZgAAQe47IH/T9U5SfkFGBL/XIR0pG3Vy7Bu6sYwdUOtiRoq3JpzVVNSg4oqRlQM81UhEHVvAv43WXn74JU0KkymW1tGytRCwWya1sU9X4Y+n7lNDdKImROY5VutgUgFmLCy4CFeglznOIzziDem1349Lxhb1eLn0yH5HMe0Z+BQ==;31:sI0jQW0Vo1tdal7/Jr+720k0ERFNRTidx0tTYGYDB24wdg8/vwNHWofw04e3geGAFuMON2RofXq+s3iIF5P5qD7BvracjaCTrAzI53rW8RvqilZy2P3QhoJi1ZmJO/eKPEI+2tddD0udMMPvIrTlcbJ4/ahdZVNLWQbIsmUaWcjALdzvspenPXx6SWtCwngSy11ARihbmCIodrJfCoBKAHlwkeGoPGJiyRATX2hUvYk=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:3wQVkR9HPz9D0z/HrMMj4XfLrLQFubK4SJKKpDwxauZC2kprE98SBIr6f0bex+ZNkeExD5PQbccMMtIsGPVlg5wG0Bz63eLFEmI5ty1B2LALa9ARQSkPgLR1yGWoJy/qHjd+NrM1x2CKUTsNaMVYw+XJDeFRYouuiLzKaN0AD8hwFSTy0sxPHxopTnOznIA14cobCNwZHuCPGID8/a7OJbmorPGd+nDOHWaC2BCP4JE9bp8HawN/pplLiAek4ttDt7QidBfeYnJLdV6xqrGMJ8/wEj/ECBp0b6/1X+Lr/CBBp1IE6Z4xVgO67CSNCg/QQE/AvQOzYmJHe/GRuVDFgYzcG8qLwW1a6/9uyI7adn3lea4l7p0LvYVMc4xcnIB0BgRo1G7hUlZf4aNJQFW8VozC8VlNWYerXO1/1951Cb1bP+7wfYC1AWVG+WChSgTteKjFUi1ZRqMC4i3Kw+eKBrWsiz8LhdQFsb0hcSYa0GMzqHzmIDsbElhjnrDfGxrd;4:NbEHiA1foIp+b8b0Ytquc/l2AHPETDeLufe2+wF5pX6U3HM3VLBrFM0HzEXFZZHlP2Ep5+dxlqSmAQPZfJzD+S8wHQMkzdesIE6TiBvL/EnXk6BzFM0cv9jrfnfs3Rb29DYtVo0xmMXpYTRUzmR2xcstor2SyHxUDh93sPt60GyeTpS4Rge+Vw4XZeg2liH24bZ5LZM8dR26d7Tbxj8BF+BSF9TqXWm6ltv2kusfitY/ZwCsXXrnybgWpzKDlpMfnERIT0SsBwQQy+ftv9uJTVzBuVhtQb6GxZ0r/C9iplqFjunX25WKpqaGpqjVv/w6
X-Microsoft-Antispam-PRVS: <DM5PR15MB1756D001F1246C4A9035614CDDF60@DM5PR15MB1756.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(11241501184)(944501161)(93006095)(93001095)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(189003)(199004)(8936002)(2906002)(98436002)(478600001)(106356001)(81166006)(81156014)(8676002)(6306002)(6916009)(6346003)(33656002)(6666003)(52116002)(47776003)(6486002)(6496006)(9686003)(229853002)(76506005)(68736007)(4326008)(76176011)(53936002)(105586002)(2950100002)(52396003)(59450400001)(7416002)(6116002)(97736004)(33896004)(316002)(186003)(15650500001)(16586007)(23726003)(5660300001)(16526019)(50466002)(6246003)(83506002)(58126008)(966005)(1076002)(54906003)(386003)(53546011)(305945005)(7736002)(25786009)(86362001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1756;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1756;23:AKHaSdLZ557JV/nwOv+T6votEMLqddqfrN7/Wvgof?=
 =?us-ascii?Q?vHmworApqRxOK7ffo3IpRWd7M7D1UmZBnbUVUYJYBxs9+Zt0taVN0FAHp24a?=
 =?us-ascii?Q?wz6tbTEjKVG5wBNMTsJwSUOZx56zVXFBHCmVTGFU1FiGZOEhaQX59BUcx+rX?=
 =?us-ascii?Q?whPFPKYcJJVbdDZh5Sg/fbxm61GZCtFY0IfcVN1GHS5XGwbJYT/bdXm/ZsnU?=
 =?us-ascii?Q?uLshiMo9VNQGWCl0WeEWrz/QWuezLrjuQcYMm4WUDKy9iZdEeTgegEWCZWyi?=
 =?us-ascii?Q?hfuHO/SlQPJhueSXoZX/Ywy0m3D98i187LSU0crcjKuJOKKyiz7V4mvynTO/?=
 =?us-ascii?Q?tRoTRVMPA8jrCl96SyEXH03HgoZNg5584NOcLIWkKfK+f3dLhXoQYMuQyjY3?=
 =?us-ascii?Q?OiGC6k/fCHSS+8zSGz4n6nBVZbNSC7xJl+l6OXz9409LWrc7JjBWhhR3zj4g?=
 =?us-ascii?Q?Yi38naRbtHirpLc4awOpLTyU3vranjTyRnpYfQCSzBeMb805g6x2y4wF8NaK?=
 =?us-ascii?Q?nOfjWueT0kfIY0c2obaWIdMEFnhryUoI0Ts7NWJc4+O4HzTrm7ZOPDNa3oFF?=
 =?us-ascii?Q?j/HO61gQ5TmCby31G9Gd5gywQUQHXlHfLuyIYMuqVUXSMGs/Kyfl7iCQG/KV?=
 =?us-ascii?Q?f2FD+x6WSEyZteQ39ElHg3xmgthXQigA/incXOvj8yoNMn6oglvIy2pZWTcT?=
 =?us-ascii?Q?Nk0TjCPwjeHs7ydahZVcTnj8gY3R3BL+c9U9dPUjTsj8xZoT8ceaL5olp4o2?=
 =?us-ascii?Q?5iN8phkfFbNUXJjpxTC3aNiWmGMED97aiQXZEBfamh2xkugnNyt4XWjHGYIt?=
 =?us-ascii?Q?hN2RvY3VcgN1dhouSWX0qCPNOou9Xnu7vjqhnvz4ShStoxlV6vyZlafDXxbv?=
 =?us-ascii?Q?qiNQ4MP7n2pZNraYSu5SYIn0Fb5bCIvV5qaRNABcvQVzXBOLYoGVJ8gqNi1a?=
 =?us-ascii?Q?prP/NvAPb7AcmsuKyx6EPEcNce4cdFFaz+XchaPZ5tTaHjIDuUxcxg6fKfBn?=
 =?us-ascii?Q?zE79SjZ4xcgfTmwkBSJTR54hGgWkVZUahIi3qNzlm4SIhvbNQNDZlij7rtRI?=
 =?us-ascii?Q?keYQLhtde0PC5J5cMxSPdg/rmhT5kkl8JiBMubBLdX+N2e677wt1St1wQNQm?=
 =?us-ascii?Q?vXY3iT9k9Yfs5YrMumn++e3QaFzAXkCs7SP5R2cC9DQQBJ9uZiEcNcsztChU?=
 =?us-ascii?Q?VYwiJJnRsMXpubkMT/mZO2y/2k7FvApJQfapBddUpoitOizTHPcKOiyr2JXm?=
 =?us-ascii?Q?hBmLvJudq/rF4zJZlATrZIKKlQVQaAZESIYZ1eaJNIC4ew57AT6wCbzu4CWL?=
 =?us-ascii?Q?X6KxfCxEcfpyIWzEevb8kotKi/w0q5Mp09T2CJoTW/usyLJbepJmASnFb9St?=
 =?us-ascii?Q?ecE6CvRdSkcadqtvYOLJb3Wqx6TYLtNCdq6fcWPH+pNBgmR?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;6:zKWwqKRxYwg7y4YnirAPG5V8H6VIsAtAk/V2zFyR9eioY1ZHGOMzE8/Mml+5KoKK/T//gRv83bv6c8/AcCHRLb8d9LL38WTHptAP2b585f9VnJuUMbDfhS3wFvr2y35GFLmfYBdILag7DzNEIXRtvh7mepsA5E1pW2Qf6SPMFJwnsb4AzQjqxjsoY4vyag1JuksHhs/sUUN42QPyqdOmP50+MIRk4McCibRaZlEw0muwkcV+o6nqQjUdi6gOPc9yyrVMTKZzp/sNiVY1KvHh8gWHRtASL3L2R0gkqR+mpgsvEFgBRnHjXeHnUXzRQeaaabeL+qJ41zIDF6NaFuvt+w7NhSrTPMJguYcTjpwMqTw=;5:4WpXVPpUmzWCE5bMzrPhppDL5ZiU63z/4Ma5QVO4Q2ymH9vy3ew63ttXWLZ1eB7nY9nyDgcsDGy4cODFg+0RJmjR1PR/ZT0PzZ6fMREPOW1JfeR/0JRSjAVRFZHwtUofVWjzkMx48DW5bxEBcRnS/iklXBkKyLJvID57nBtH058=;24:g9HdAaO1amMILQ/N1PDMo7xvvXOS0FxYqd4uJM1P2ZZnxe0flUlWlKo3+DCH1syEOMq72GAH1mBShO1SWAk06FlPCB12NcV7Lb9ACxtDboQ=;7:mKhyKyDNHI1YdMUA+A5Jk27fMe3i1Bmg3xhrInSLVV+Yg9tLMTqBfxBmwpj3wMrgtx1XbrvVT5dXGHNGbEyLVFYPP8e7RqDdEnzXTmJ/XHc7lwYtuy94I/PU4rumbk77ZaPI+9ue1qpVsVIjUQ2pUd1b4WGodFtJMTXjHmwJHQjYCwdA8M7tHrXKJmIa1wsZzED9WUPtR/+Q90v2MK/6XQzetXtjlkkfok1q62aE9eTXcugJ/QglnVayZRTVec9e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:VnCtFVxyOcZx0IGmUfvhZZHHQFjwcDT3njcbuZoEcNPfnBYs9XslofrmXmUJDujYr3ikoZ5HiOkmcsWk4TlZHW6sdckNXmhqAzrqwYY80xgqOO1leqU1L6h1QnEQ2OtXhdD0+nhp/XDv0qSFObxoCyWOjZBIdg4M0b+wfunBGjA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 18:42:25.3648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1562b5-1aad-4750-e92a-08d5731186c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/18 08:42 AM, Stephan Mueller wrote:
> > +static int gcmaes_encrypt_sg(struct aead_request *req, unsigned int
> > assoclen, +			u8 *hash_subkey, u8 *iv, void *aes_ctx)
> > +{
> > +	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
> > +	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
> > +	struct gcm_context_data data AESNI_ALIGN_ATTR;
> > +	struct scatter_walk dst_sg_walk = {};
> > +	unsigned long left = req->cryptlen;
> > +	unsigned long len, srclen, dstlen;
> > +	struct scatter_walk src_sg_walk;
> > +	struct scatterlist src_start[2];
> > +	struct scatterlist dst_start[2];
> > +	struct scatterlist *src_sg;
> > +	struct scatterlist *dst_sg;
> > +	u8 *src, *dst, *assoc;
> > +	u8 authTag[16];
> > +
> > +	assoc = kmalloc(assoclen, GFP_ATOMIC);
> > +	if (unlikely(!assoc))
> > +		return -ENOMEM;
> > +	scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
> 
> Have you tested that this code does not barf when assoclen is 0?
> 
> Maybe it is worth while to finally add a test vector to testmgr.h which 
> validates such scenario. If you would like, here is a vector you could add to 
> testmgr:
> 
> https://github.com/smuellerDD/libkcapi/blob/master/test/test.sh#L315

I tested assoclen and cryptlen being 0 and it works, yes.  Both
kmalloc and scatterwalk_map_and_copy work correctly with 0 assoclen.

> This is a decryption of gcm(aes) with no message, no AAD and just a tag. The 
> result should be EBADMSG.
> > +
> > +	src_sg = scatterwalk_ffwd(src_start, req->src, req->assoclen);
> 
> Why do you use assoclen in the map_and_copy, and req->assoclen in the ffwd?

If I understand correctly, rfc4106 appends extra data after the assoc.
assoclen is the real assoc length, req->assoclen is assoclen + the
extra data length.  So we ffwd by req->assoclen in the scatterlist,
but use assoclen when memcpy and testing.

> > 
> > +static int gcmaes_decrypt_sg(struct aead_request *req, unsigned int
> > assoclen, +			u8 *hash_subkey, u8 *iv, void *aes_ctx)
> > +{
> 
> This is a lot of code duplication.

I will merge them and send a V2.

> Ciao
> Stephan
> 
> 

Thanks!
